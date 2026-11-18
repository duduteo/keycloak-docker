<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=true; section>
    <#if section = "header">
        ${msg("viajisEscolherSegundoFatorTitulo")}
    <#elseif section = "form">
        <form id="kc-escolher-segundo-fator" class="${properties.kcFormClass!}" action="${url.loginAction}" method="post">
            <p>${msg("viajisEscolherSegundoFatorIntro")}</p>
            <div style="display:flex;flex-direction:column;gap:12px;margin-top:16px">
                <button type="submit" name="segundoFator" value="totp" class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonBlockClass!}" style="min-height:64px;text-align:left">
                    <strong>${msg("viajisEscolherTotp")}</strong><br><span>${msg("viajisEscolherTotpAjuda")}</span>
                </button>
                <button type="submit" name="segundoFator" value="webauthn" class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonBlockClass!}" style="min-height:64px;text-align:left">
                    <strong>${msg("viajisEscolherWebauthn")}</strong><br><span>${msg("viajisEscolherWebauthnAjuda")}</span>
                </button>
            </div>
        </form>
    </#if>
</@layout.registrationLayout>
