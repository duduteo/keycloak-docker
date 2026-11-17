<#outputformat "plainText">
<#assign requiredActionsText><#if requiredActions??><#list requiredActions><#items as reqActionItem>${msg("requiredAction.${reqActionItem}")}<#sep>, </#sep></#items></#list></#if></#assign>
<#assign onlyPassword = requiredActions?? && requiredActions?size == 1 && requiredActions?seq_contains("UPDATE_PASSWORD")>
</#outputformat>
<#import "template.ftl" as layout>
<@layout.emailLayout title=msg("viajisExecuteActionsTitle") preheader=msg("viajisExecuteActionsIntro")>
<@layout.title text=msg("viajisExecuteActionsTitle") />
<p>${msg("viajisExecuteActionsIntro")}</p>
<#if !onlyPassword><p>${msg("viajisExecuteActionsSteps", requiredActionsText)}</p></#if>
<@layout.actionButton url=link text=(onlyPassword?then(msg("viajisExecuteActionsPasswordButton"), msg("viajisExecuteActionsButton"))) fallback=msg("viajisButtonFallback") />
<p>${msg("viajisLinkExpires", linkExpirationFormatter(linkExpiration))}</p>
<p>${msg("viajisExecuteActionsIgnore")}</p>
</@layout.emailLayout>
