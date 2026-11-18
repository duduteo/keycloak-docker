package pt.viajis.keycloak;

import java.util.List;
import org.keycloak.Config;
import org.keycloak.authentication.Authenticator;
import org.keycloak.authentication.AuthenticatorFactory;
import org.keycloak.models.AuthenticationExecutionModel.Requirement;
import org.keycloak.models.KeycloakSession;
import org.keycloak.models.KeycloakSessionFactory;
import org.keycloak.provider.ProviderConfigProperty;

public class EscolherSegundoFatorAuthenticatorFactory implements AuthenticatorFactory {

    public static final String ID = "viajis-escolher-segundo-fator";
    private static final EscolherSegundoFatorAuthenticator SINGLETON = new EscolherSegundoFatorAuthenticator();
    private static final Requirement[] REQUIREMENTS = {Requirement.REQUIRED, Requirement.DISABLED};

    @Override
    public String getId() {
        return ID;
    }

    @Override
    public String getDisplayType() {
        return "Viajis: escolher o segundo fator";
    }

    @Override
    public String getReferenceCategory() {
        return "viajis-escolher-segundo-fator";
    }

    @Override
    public String getHelpText() {
        return "Quem ainda não tem segundo fator escolhe entre a aplicação autenticadora e uma chave de acesso (passkey).";
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
