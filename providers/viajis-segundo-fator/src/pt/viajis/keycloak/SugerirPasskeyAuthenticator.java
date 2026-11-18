package pt.viajis.keycloak;

import jakarta.ws.rs.core.MultivaluedMap;
import java.time.Duration;
import java.time.Instant;
import org.keycloak.authentication.AuthenticationFlowContext;
import org.keycloak.authentication.Authenticator;
import org.keycloak.models.KeycloakSession;
import org.keycloak.models.RealmModel;
import org.keycloak.models.UserModel;

/**
 * Viajis: depois de entrar (senha e segundo fator), quem ainda não tem uma chave de acesso (passkey) sem senha recebe um convite para a registar neste dispositivo.
 * «Configurar agora» junta a ação obrigatória webauthn-register-passwordless; «Agora não» adia 14 dias; «Não voltar a perguntar» não volta a aparecer.
 * Não aparece a quem acabou de escolher o método no primeiro registo, nem a quem já tem uma passkey, nem a quem ainda não tem nenhum segundo fator (esse passa pela escolha).
 */
public class SugerirPasskeyAuthenticator implements Authenticator {

    static final String PAGE = "viajis-sugerir-passkey.ftl";
    static final String FIELD = "passkey";
    static final String AGORA = "agora";
    static final String DEPOIS = "depois";
    static final String NUNCA = "nunca";
    static final String NOTA_ACABOU_DE_ESCOLHER = "viajis-acabou-de-escolher-segundo-fator";
    static final String ATRIBUTO_ADIADO_ATE = "viajis_passkey_adiado_ate";
    static final String ATRIBUTO_NAO_PERGUNTAR = "viajis_passkey_nao_perguntar";
    static final Duration ADIAMENTO = Duration.ofDays(14);

    @Override
    public void authenticate(AuthenticationFlowContext context) {
        if (deveSugerir(context)) {
            context.challenge(context.form().createForm(PAGE));
            return;
        }
        context.success();
    }

    private boolean deveSugerir(AuthenticationFlowContext context) {
        UserModel user = context.getUser();
        if (user == null) return false;
        if ("true".equals(context.getAuthenticationSession().getAuthNote(NOTA_ACABOU_DE_ESCOLHER))) return false;
        if (tem(user, "webauthn-passwordless")) return false;
        // Sem segundo fator ainda: o passo de escolha trata dele.
        if (!tem(user, "otp") && !tem(user, "webauthn") && !tem(user, "recovery-authn-codes")) return false;
        if ("true".equals(user.getFirstAttribute(ATRIBUTO_NAO_PERGUNTAR))) return false;
        String ate = user.getFirstAttribute(ATRIBUTO_ADIADO_ATE);
        if (ate != null) {
            try {
                if (Instant.ofEpochSecond(Long.parseLong(ate)).isAfter(Instant.now())) return false;
            } catch (NumberFormatException ignorado) {
                // um valor estragado não pode calar o convite para sempre
            }
        }
        return true;
    }

    @Override
    public void action(AuthenticationFlowContext context) {
        MultivaluedMap<String, String> form = context.getHttpRequest().getDecodedFormParameters();
        String escolha = form.getFirst(FIELD);
        UserModel user = context.getUser();
        if (AGORA.equals(escolha)) {
            context.getAuthenticationSession().addRequiredAction("webauthn-register-passwordless");
            AcoesPasskey.priorizarSeRegistada(context);
        } else if (NUNCA.equals(escolha)) {
            user.setSingleAttribute(ATRIBUTO_NAO_PERGUNTAR, "true");
        } else if (DEPOIS.equals(escolha)) {
            user.setSingleAttribute(ATRIBUTO_ADIADO_ATE, Long.toString(Instant.now().plus(ADIAMENTO).getEpochSecond()));
        } else {
            context.challenge(context.form().createForm(PAGE));
            return;
        }
        context.success();
    }

    private static boolean tem(UserModel user, String tipo) {
        return user.credentialManager().getStoredCredentialsByTypeStream(tipo).findAny().isPresent();
    }

    @Override
    public boolean requiresUser() {
        return true;
    }

    /** Verdadeiro de propósito (ver EscolherSegundoFatorAuthenticator): o passo decide sozinho se mostra a página. */
    @Override
    public boolean configuredFor(KeycloakSession session, RealmModel realm, UserModel user) {
        return true;
    }

    @Override
    public void setRequiredActions(KeycloakSession session, RealmModel realm, UserModel user) {
    }

    @Override
    public void close() {
    }
}
