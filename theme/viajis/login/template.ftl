<#import "field.ftl" as field>
<#import "footer.ftl" as loginFooter>
<#import "theme-resources.ftl" as themeResourceTags>
<#macro username>
  <#assign label>
    <#if !realm.loginWithEmailAllowed>${msg("username")}<#elseif !realm.registrationEmailAsUsername>${msg("usernameOrEmail")}<#else>${msg("email")}</#if>
  </#assign>
  <@field.group name="username" label=label>
    <div class="${properties.kcInputGroup}">
      <div class="${properties.kcInputGroupItemClass} ${properties.kcFill}">
        <span class="${properties.kcInputClass} ${properties.kcFormReadOnlyClass}">
          <input id="kc-attempted-username" value="${auth.attemptedUsername}" readonly>
        </span>
      </div>
      <div class="${properties.kcInputGroupItemClass}">
        <button id="reset-login" class="${properties.kcFormPasswordVisibilityButtonClass} kc-login-tooltip" type="button" 
              aria-label="${msg('restartLoginTooltip')}" onclick="location.href='${url.loginRestartFlowUrl}'">
            <i class="fa-sync-alt fas" aria-hidden="true"></i>
            <span class="kc-tooltip-text">${msg("restartLoginTooltip")}</span>
        </button>
      </div>
    </div>
  </@field.group>
</#macro>

<#macro registrationLayout bodyClass="" displayInfo=false displayMessage=true displayRequiredFields=false>
<!DOCTYPE html>
<html class="${properties.kcHtmlClass!}" lang="${lang}"<#if realm.internationalizationEnabled> dir="${(locale.rtl)?then('rtl','ltr')}"</#if>>

<head>
    <meta charset="utf-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="robots" content="noindex, nofollow">
    <meta name="color-scheme" content="light${darkMode?then(' dark', '')}">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <#if properties.meta?has_content>
        <#list properties.meta?split(' ') as meta>
            <meta name="${meta?split('==')[0]}" content="${meta?split('==')[1]}"/>
        </#list>
    </#if>
    <title>${msg("viajisPageTitle")}</title>
    <link rel="icon" type="image/svg+xml" href="${url.resourcesPath}/img/favicon.svg" />
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@500;600;700&family=Inter:wght@400;500;600;700;800&display=swap" />
    <#if themeResources?? && themeResources.stylesCommon?has_content>
        <@themeResourceTags.renderStyles themeResources.stylesCommon url.resourcesCommonPath />
    <#elseif properties.stylesCommon?has_content>
        <#list properties.stylesCommon?split(' ') as style>
            <link href="${url.resourcesCommonPath}/${style}" rel="stylesheet" />
        </#list>
    </#if>
    <#if themeResources?? && themeResources.styles?has_content>
        <@themeResourceTags.renderStyles themeResources.styles url.resourcesPath />
    <#elseif properties.styles?has_content>
        <#list properties.styles?split(' ') as style>
            <link href="${url.resourcesPath}/${style}" rel="stylesheet" />
        </#list>
    </#if>
    <script type="importmap">
        {
            "imports": {
                "rfc4648": "${url.resourcesCommonPath}/vendor/rfc4648/rfc4648.js"
            }
        }
    </script>
    <#if darkMode>
      <script type="module" async blocking="render">
          <#outputformat "JavaScript">
          const DARK_MODE_CLASS = ${properties.kcDarkModeClass?c};
          const mediaQuery = window.matchMedia("(prefers-color-scheme: dark)");

          updateDarkMode(mediaQuery.matches);
          mediaQuery.addEventListener("change", (event) => updateDarkMode(event.matches));

          function updateDarkMode(isEnabled) {
            const { classList } = document.documentElement;

            if (isEnabled) {
              classList.add(DARK_MODE_CLASS);
            } else {
              classList.remove(DARK_MODE_CLASS);
            }
          }
          </#outputformat>
      </script>
    </#if>
    <#if themeResources?? && themeResources.scripts?has_content>
        <@themeResourceTags.renderScripts themeResources.scripts url.resourcesPath "text/javascript" />
    <#elseif properties.scripts?has_content>
        <#list properties.scripts?split(' ') as script>
            <script src="${url.resourcesPath}/${script}" type="text/javascript"></script>
        </#list>
    </#if>
    <#if scripts??>
        <#list scripts as script>
            <script src="${script}" type="text/javascript"></script>
        </#list>
    </#if>
    <script type="module" src="${url.resourcesPath}/js/passwordVisibility.js"></script>
    <script type="module">
        <#outputformat "JavaScript">
        import { startSessionPolling } from ${(url.resourcesPath + "/js/authChecker.js")?c};

        startSessionPolling(
            ${url.ssoLoginInOtherTabsUrl?c}
        );
        </#outputformat>
    </script>
    <script type="module">
        document.addEventListener("click", (event) => {
            const link = event.target.closest("a[data-once-link]");

            if (!link) {
                return;
            }

            if (link.getAttribute("aria-disabled") === "true") {
                event.preventDefault();
                return;
            }

            const { disabledClass } = link.dataset;

            if (disabledClass) {
                link.classList.add(...disabledClass.trim().split(/\s+/));
            }

            link.setAttribute("role", "link");
            link.setAttribute("aria-disabled", "true");
        });
    </script>
    <#if authenticationSession??>
        <script type="module">
             <#outputformat "JavaScript">
            import { checkAuthSession } from ${(url.resourcesPath + "/js/authChecker.js")?c};

            checkAuthSession(
                ${authenticationSession.authSessionIdHash?c}
            );
            </#outputformat>
        </script>
    </#if>
    <script>
      // Workaround for https://bugzilla.mozilla.org/show_bug.cgi?id=1404468
      const isFirefox = true;
    </script>
</head>

<body id="keycloak-bg" class="${properties.kcBodyClass!}" data-page-id="login-${pageId}">
<div class="vj-grid">
  <div class="vj-left">
    <div class="vj-left-inner">
      <#-- A marca da agência do endereço (marca-agencia-login D1-11): a organização do Keycloak que o Viajis sincroniza. Sem ela, «VIAJIS» como sempre. -->
      <#assign vjAgencyName = (org.attributes["viajis_nome"][0])!"">
      <#assign vjAgencyLogo = (org.attributes["viajis_logotipo"][0])!"">
      <#if !vjAgencyLogo?starts_with("https://")><#assign vjAgencyLogo = ""></#if>
      <#if vjAgencyName?has_content || vjAgencyLogo?has_content>
      <div class="vj-agency">
        <#-- Um logotipo que não carrega sai; sem nome da agência, volta «VIAJIS» (a marca nunca fica vazia). -->
        <#if vjAgencyLogo?has_content><img class="vj-agency-logo" src="${vjAgencyLogo}" alt="" onerror="var m=this.closest('.vj-left-inner');this.remove();if(!m.querySelector('.vj-agency-name'))m.querySelector('.vj-brand').hidden=false;" /></#if>
        <#if vjAgencyName?has_content><span class="vj-agency-name">${vjAgencyName}</span></#if>
      </div>
      <span class="vj-brand" hidden>VIAJIS</span>
      <#else>
      <span class="vj-brand">VIAJIS</span>
      </#if>
      <h1 class="vj-headline">${msg("viajisHeadline")}</h1>
      <p class="vj-lead">${msg("viajisLead")}</p>

      <div class="vj-card">
        <main class="${properties.kcLoginMain!}">
          <div class="${properties.kcLoginMainHeader!}">
            <h2 class="vj-card-title" id="kc-page-title"><#nested "header"></h2>
            <#if realm.internationalizationEnabled  && locale.supported?size gt 1>
            <div class="${properties.kcLoginMainHeaderUtilities!}">
              <div class="${properties.kcInputClass!}">
                <select aria-label="${msg("languages")}" id="login-select-toggle" onchange="if (this.value) window.location.href=this.value">
                  <#list locale.supported?sort_by("label") as l>
                    <option value="${l.url}" ${(l.languageTag == locale.currentLanguageTag)?then('selected','')}>${l.label}</option>
                  </#list>
                </select>
              </div>
            </div>
            </#if>
          </div>
          <div class="${properties.kcLoginMainBody!}">
            <#if displayRequiredFields>
                <div class="${properties.kcContentWrapperClass!}">
                    <div class="${properties.kcLabelWrapperClass!} subtitle">
                        <span class="${properties.kcInputHelperTextItemTextClass!}">
                          <span class="${properties.kcInputRequiredClass!}">*</span> ${msg("requiredFields")}
                        </span>
                    </div>
                </div>
            </#if>
            <#if auth?has_content && auth.showUsername() && !auth.showResetCredentials()>
                <div class="${properties.kcFormClass} ${properties.kcContentWrapperClass}">
                  <#nested "show-username">
                  <@username />
                </div>
            </#if>

            <#if displayMessage && message?has_content && (message.type != 'warning' || !isAppInitiatedAction??)>
                <div class="vj-alert vj-alert-${message.type}" role="alert">
                    <span class="${properties.kcAlertTitleClass!} kc-feedback-text">${message.summary}</span>
                </div>
            </#if>

            <#nested "form">

            <#if auth?has_content && auth.showTryAnotherWayLink()>
              <form id="kc-select-try-another-way-form" action="${url.loginAction}" method="post" novalidate="novalidate">
                  <input type="hidden" name="tryAnotherWay" value="on"/>
                  <a id="try-another-way" href="javascript:document.forms['kc-select-try-another-way-form'].requestSubmit()"
                      class="${properties.kcButtonSecondaryClass} ${properties.kcButtonBlockClass} ${properties.kcMarginTopClass}">
                        ${msg("doTryAnotherWay")}
                  </a>
              </form>
            </#if>


            <div class="${properties.kcLoginMainFooter!}">
                <#-- Uma agência que só entra com email e senha (atributo login_apenas_senha=true na organização, posto à mão no Keycloak) não vê os
                     botões dos fornecedores de identidade, como o Office 365. A sincronização do Viajis não mexe neste atributo. -->
                <#if ((org.attributes["login_apenas_senha"][0])!"") != "true">
                <#nested "socialProviders">
                </#if>
                <#if displayInfo>
                    <div id="kc-info" class="${properties.kcLoginMainFooterBand!} ${properties.kcFormClass}">
                        <div id="kc-info-wrapper" class="${properties.kcLoginMainFooterBandItem!}">
                            <#nested "info">
                        </div>
                    </div>
                </#if>
            </div>
          </div>
          <div class="${properties.kcLoginMainFooter!}">
              <@loginFooter.content/>
          </div>
        </main>
      </div>
    </div>
  </div>

  <div class="vj-right" aria-hidden="false">
    <img class="vj-right-img" src="${url.resourcesPath}/img/japao-capa.jpg" alt="" aria-hidden="true" />
    <div class="vj-right-overlay" aria-hidden="true"></div>
    <div class="vj-right-content">
      <ul class="vj-bullets">
        <li>${msg("viajisBullet1")}</li>
        <li>${msg("viajisBullet2")}</li>
        <li>${msg("viajisBullet3")}</li>
      </ul>
    </div>
  </div>
</div>
</body>
</html>
</#macro>
