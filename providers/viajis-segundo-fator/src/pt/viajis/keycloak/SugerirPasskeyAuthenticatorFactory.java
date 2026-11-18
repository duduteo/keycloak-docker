package pt.viajis.keycloak;

import java.util.List;
import org.keycloak.Config;
import org.keycloak.authentication.Authenticator;
import org.keycloak.authentication.AuthenticatorFactory;
import org.keycloak.models.AuthenticationExecutionModel.Requirement;
import org.keycloak.models.KeycloakSession;
import org.keycloak.models.KeycloakSessionFactory;
import org.keycloak.provider.ProviderConfigProperty;

public class SugerirPasskeyAuthenticatorFactory implements AuthenticatorFactory {

    public static final String ID = "viajis-sugerir-passkey";
    private static final SugerirPasskeyAuthenticator SINGLETON = new SugerirPasskeyAuthenticator();
    private static final Requirement[] REQUIREMENTS = {Requirement.REQUIRED, Requirement.DISABLED};

    @Override
    public String getId() {
        return ID;
    }

    @Override
    public String getDisplayType() {
        return "Viajis: sugerir a chave de acesso (passkey)";
    }

    @Override
    public String getReferenceCategory() {
        return "viajis-sugerir-passkey";
    }

    @Override
    public String getHelpText() {
        return "Convida quem entrou e ainda não tem uma chave de acesso (passkey) sem senha a registá-la; adia 14 dias ou não volta a perguntar.";
    }

    @Override
    public boolean isConfigurable() {
        return false;
    }

    @Override
    public Requirement[] getRequirementChoices() {
        return REQUIREMENTS;
    }

    @Override
    public boolean isUserSetupAllowed() {
        return false;
    }

    @Override
    public List<ProviderConfigProperty> getConfigProperties() {
        return List.of();
    }

    @Override
    public Authenticator create(KeycloakSession session) {
        return SINGLETON;
    }

    @Override
    public void init(Config.Scope config) {
    }

    @Override
    public void postInit(KeycloakSessionFactory factory) {
    }

    @Override
    public void close() {
    }
}
