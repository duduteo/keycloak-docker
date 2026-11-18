package pt.viajis.keycloak;

import org.keycloak.Config;
import org.keycloak.authentication.RequiredActionFactory;
import org.keycloak.authentication.RequiredActionProvider;
import org.keycloak.models.KeycloakSession;
import org.keycloak.models.KeycloakSessionFactory;

public class PriorizarPasskeyRequiredActionFactory implements RequiredActionFactory {

    public static final String ID = "viajis-priorizar-passkey";
    private static final PriorizarPasskeyRequiredAction SINGLETON = new PriorizarPasskeyRequiredAction();

    @Override
    public String getId() {
        return ID;
    }

    @Override
    public String getDisplayText() {
        return "Viajis: passkey em primeiro lugar";
    }

    @Override
    public RequiredActionProvider create(KeycloakSession session) {
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
