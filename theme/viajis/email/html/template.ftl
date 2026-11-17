<#-- A moldura dos emails do Keycloak do Viajis. É a mesma dos emails do sistema (EmailFrame, no backend): mudar um implica mudar o outro. -->
<#macro emailLayout title="" preheader="">
<#assign brand = (properties.viajisBrandColor)!"#1E64EF">
<#assign logoUrl = (properties.viajisLogoUrl)!"">
<!doctype html>
<html lang="${locale.language}" dir="${(ltr)?then('ltr','rtl')}">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<meta name="color-scheme" content="light dark">
<meta name="supported-color-schemes" content="light dark">
<title>${title}</title>
<style>
p{margin:0 0 10px}.card a{overflow-wrap:anywhere;word-break:break-word}
@media (max-width:620px){.container{width:100%!important;border-radius:0!important}.px{padding-left:20px!important;padding-right:20px!important}}
@media (prefers-color-scheme:dark){.bg-page{background:#0B1020!important}.card{background:#141B2D!important;border-color:#26304D!important}.card p,.card span,.card strong,.card td{color:#E6EAF2!important}.card a:not(.btn){color:#9DB8FF!important}.foot{background:#10172A!important;border-color:#26304D!important}.logo-tile{background:#FFFFFF!important;padding:6px 10px!important;border-radius:6px!important}}
</style>
</head>
<body class="bg-page" style="margin:0;padding:0;background:#EEF2F7;-webkit-text-size-adjust:100%">
<#if preheader?has_content><div style="display:none;max-height:0;overflow:hidden;opacity:0;font-size:1px;line-height:1px;color:#EEF2F7">${preheader}&#8199;&#847;&#8199;&#847;&#8199;&#847;</div></#if>
<table role="presentation" width="100%" cellpadding="0" cellspacing="0" border="0" class="bg-page" style="background:#EEF2F7"><tr><td align="center" style="padding:24px 12px">
<table role="presentation" width="600" cellpadding="0" cellspacing="0" border="0" class="container card" style="width:600px;max-width:100%;background:#FFFFFF;border:1px solid #E3E8F0;border-radius:12px;overflow:hidden">
<tr><td height="4" style="height:4px;line-height:4px;font-size:0;background:${brand}">&nbsp;</td></tr>
<tr><td class="px" style="padding:24px 32px 4px"><table role="presentation" cellpadding="0" cellspacing="0" border="0"><tr><#if logoUrl?has_content><td class="logo-tile"><img src="${logoUrl}" alt="Travel4Tech" height="48" style="height:48px;width:auto;max-width:100%;border:0"></td><#else><td><span style="font-family:Arial,Helvetica,sans-serif;font-size:22px;font-weight:bold;color:#0F172A">Travel4Tech</span></td></#if></tr></table></td></tr>
<tr><td class="px" style="padding:16px 32px 28px;font-family:Arial,Helvetica,sans-serif;font-size:16px;line-height:24px;color:#1E293B">
<#nested>
</td></tr>
</table></td></tr></table>
</body>
</html>
</#macro>

<#-- O botão de ação: tabela com bgcolor (o Outlook só entende assim) e, por baixo, o endereço por extenso. -->
<#macro actionButton url text fallback>
<#assign brandColor = (properties.viajisBrandColor)!"#1E64EF">
<table cellpadding="0" cellspacing="0" border="0" style="margin:4px 0 8px"><tr><td bgcolor="${brandColor}" style="background-color:${brandColor};border-radius:8px;padding:14px 28px;text-align:center"><a class="btn" href="${url}" style="font-family:Arial,Helvetica,sans-serif;font-size:16px;font-weight:bold;color:#FFFFFF;text-decoration:none">${text}</a></td></tr></table>
<p><span style="font-family:Arial,Helvetica,sans-serif;font-size:13px;color:#64748B">${fallback}<br><a href="${url}" style="color:${brandColor};word-break:break-all">${url}</a></span></p>
</#macro>

<#macro title text>
<p><strong><span style="font-family:Arial,Helvetica,sans-serif;font-size:24px;color:#0F172A">${text}</span></strong></p>
</#macro>
