<#import "template.ftl" as layout>
<@layout.emailLayout title=msg("viajisPasswordResetTitle") preheader=msg("viajisPasswordResetIntro")>
<@layout.title text=msg("viajisPasswordResetTitle") />
<p>${msg("viajisPasswordResetIntro")}</p>
<@layout.actionButton url=link text=msg("viajisPasswordResetButton") fallback=msg("viajisButtonFallback") />
<p>${msg("viajisLinkExpires", linkExpirationFormatter(linkExpiration))}</p>
<p>${msg("viajisPasswordResetIgnore")}</p>
</@layout.emailLayout>
