<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=true; section>
    <#if section = "header">
        ${msg("viajisPasskeyTitulo")}
    <#elseif section = "form">
        <form id="kc-sugerir-passkey" class="${properties.kcFormClass!}" action="${url.loginAction}" method="post">
            <p>${msg("viajisPasskeyIntro")}</p>
            <p>${msg("viajisPasskeyPartilhado")}</p>
            <div style="display:flex;flex-direction:column;gap:12px;margin-top:16px">
                <button type="submit" name="passkey" value="agora" class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonBlockClass!}">${msg("viajisPasskeyAgora")}</button>
                <button type="submit" name="passkey" value="depois" class="${properties.kcButtonClass!} ${properties.kcButtonSecondaryClass!} ${properties.kcButtonBlockClass!}">${msg("viajisPasskeyDepois")}</button>
                <button type="submit" name="passkey" value="nunca" class="${properties.kcButtonClass!} ${properties.kcButtonLinkClass!} ${properties.kcButtonBlockClass!}">${msg("viajisPasskeyNunca")}</button>
            </div>
        </form>
    </#if>
</@layout.registrationLayout>
