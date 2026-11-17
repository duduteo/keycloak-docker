<#import "template.ftl" as layout>
<@layout.emailLayout title=msg("viajisEmailTestTitle") preheader=msg("viajisEmailTestIntro")>
<@layout.title text=msg("viajisEmailTestTitle") />
<p>${msg("viajisEmailTestIntro")}</p>
</@layout.emailLayout>
