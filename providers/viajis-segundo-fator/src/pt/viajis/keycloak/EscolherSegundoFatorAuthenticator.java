package pt.viajis.keycloak;

import jakarta.ws.rs.core.MultivaluedMap;
import jakarta.ws.rs.core.Response;
import org.keycloak.authentication.AuthenticationFlowContext;
import org.keycloak.authentication.Authenticator;
import org.keycloak.models.KeycloakSession;
import org.keycloak.models.RealmModel;
import org.keycloak.models.UserModel;

/**
 * Viajis: quem entra sem segundo fator escolhe qual registar — a aplicação autenticadora (TOTP) ou uma chave de acesso (passkey, chave de segurança, impressão digital, rosto ou PIN).
 * Entra no subfluxo «configurar o segundo fator» (só corre a quem ainda não tem nenhum) no lugar do passo fixo do autenticador. A escolha junta a ação obrigatória do Keycloak
 * correspondente (CONFIGURE_TOTP ou webauthn-register); o registo em si é o do Keycloak.
 */
public class EscolherSegundoFatorAuthenticator implements Authenticator {

    static final String PAGE = "viajis-escolher-segundo-fator.ftl";
    static final String FIELD = "segundoFator";
    static final String TOTP = "totp";
    static final String WEBAUTHN = "webauthn";

    @Override
    public void authenticate(AuthenticationFlowContext context) {
        if (temSegundoFator(context.getUser())) {
            context.success();
            return;
        }
        context.challenge(context.form().createForm(PAGE));
    }

    @Override
    public void action(AuthenticationFlowContext context) {
        MultivaluedMap<String, String> form = context.getHttpRequest().getDecodedFormParameters();
        String escolha = form.getFirst(FIELD);
        if (TOTP.equals(escolha)) {
            context.getAuthenticationSession().addRequiredAction(UserModel.RequiredAction.CONFIGURE_TOTP);
        } else if (WEBAUTHN.equals(escolha)) {
            context.getAuthenticationSession().addRequiredAction("webauthn-register");
        } else {
            // Sem escolha (ou valor desconhecido): mostra a página de novo. Nunca avança sem registar um segundo fator.
            Response again = context.form().createForm(PAGE);
            context.challenge(again);
            return;
        }
        context.success();
    }

    static boolean temSegundoFator(UserModel user) {
        if (user == null) return false;
        for (String tipo : new String[] {"otp", "webauthn", "webauthn-passwordless"}) {
            if (user.credentialManager().getStoredCredentialsByTypeStream(tipo).findAny().isPresent()) return true;
        }
        return false;
    }

    @Override
    public boolean requiresUser() {
        return true;
    }

    /** Verdadeiro de propósito: um passo obrigatório «não configurado» seria ignorado pelo Keycloak (só juntava ações); aqui queremos sempre mostrar a escolha. */
    @Override
    public boolean configuredFor(KeycloakSession session, RealmModel realm, UserModel user) {
        return true;
    }

    @Override
    public void setRequiredActions(KeycloakSession session, RealmModel realm, UserModel user) {
        // nada: a ação obrigatória só se junta depois da escolha
    }

    @Override
    public void close() {
    }
}
