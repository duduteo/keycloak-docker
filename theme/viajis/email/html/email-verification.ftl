<#import "template.ftl" as layout>
<@layout.emailLayout title=msg("viajisEmailVerificationTitle") preheader=msg("viajisEmailVerificationIntro")>
<@layout.title text=msg("viajisEmailVerificationTitle") />
<p>${msg("viajisEmailVerificationIntro")}</p>
<@layout.actionButton url=link text=msg("viajisEmailVerificationButton") fallback=msg("viajisButtonFallback") />
<p>${msg("viajisLinkExpires", linkExpirationFormatter(linkExpiration))}</p>
<p>${msg("viajisEmailVerificationIgnore")}</p>
</@layout.emailLayout>
