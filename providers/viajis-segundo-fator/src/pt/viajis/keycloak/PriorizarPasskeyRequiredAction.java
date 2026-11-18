package pt.viajis.keycloak;

import org.keycloak.authentication.RequiredActionContext;
import org.keycloak.authentication.RequiredActionProvider;
import org.keycloak.models.UserModel;

/**
 * Viajis: corre logo a seguir ao registo da passkey sem senha e põe-na em primeiro lugar na lista de credenciais da pessoa. O Keycloak mostra primeiro, no login, a credencial que está no topo
 * dessa lista (por omissão a senha, a mais antiga): sem isto, quem registou a passkey continuava a ver o campo da senha depois do email.
 * Não pede nada à pessoa: nunca mostra uma página.
 */
public class PriorizarPasskeyRequiredAction implements RequiredActionProvider {

    @Override
    public void evaluateTriggers(RequiredActionContext context) {
    }

    @Override
    public void requiredActionChallenge(RequiredActionContext context) {
        UserModel user = context.getUser();
        user.credentialManager().getStoredCredentialsByTypeStream("webauthn-passwordless")
                .reduce((primeira, segunda) -> segunda) // a mais recente (a que acabou de ser registada)
                .ifPresent(passkey -> user.credentialManager().moveStoredCredentialTo(passkey.getId(), null));
        context.success();
    }

    @Override
    public void processAction(RequiredActionContext context) {
        context.success();
    }

    @Override
    public void close() {
    }
}
