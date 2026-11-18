package pt.viajis.keycloak;

import org.keycloak.authentication.AuthenticationFlowContext;
import org.keycloak.models.RequiredActionProviderModel;

final class AcoesPasskey {

    private AcoesPasskey() {
    }

    /** Junta «passkey em primeiro lugar» só se o realm a tem registada e ligada: sem isso o Keycloak não saberia que ação correr. */
    static void priorizarSeRegistada(AuthenticationFlowContext context) {
        RequiredActionProviderModel acao = context.getRealm().getRequiredActionProviderByAlias(PriorizarPasskeyRequiredActionFactory.ID);
        if (acao != null && acao.isEnabled()) {
            context.getAuthenticationSession().addRequiredAction(PriorizarPasskeyRequiredActionFactory.ID);
        }
    }
}
