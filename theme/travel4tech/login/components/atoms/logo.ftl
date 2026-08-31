<#macro kw>
  <div class="flex flex-col items-center gap-3">
    <svg aria-hidden="true" class="t4t-logo-mark" height="40" viewBox="0 0 64 64" width="40" xmlns="http://www.w3.org/2000/svg">
      <defs>
        <linearGradient id="t4tLoginMark" x1="6%" x2="94%" y1="6%" y2="94%">
          <stop offset="0%" stop-color="#4286ff" />
          <stop offset="100%" stop-color="#965ef8" />
        </linearGradient>
      </defs>

      <rect fill="#060c20" height="64" rx="14" width="64" x="0" y="0" />

      <line stroke="#4286ff" stroke-linecap="round" stroke-opacity="0.55" stroke-width="3" x1="44" x2="22" y1="33" y2="20" />
      <line stroke="#4286ff" stroke-linecap="round" stroke-opacity="0.55" stroke-width="3" x1="44" x2="20" y1="33" y2="46" />
      <line stroke="#9aa5b8" stroke-dasharray="2.6 5" stroke-linecap="round" stroke-opacity="0.45" stroke-width="2.2" x1="44" x2="46.1" y1="33" y2="16.9" />

      <circle cx="22" cy="20" fill="#f2f5fb" r="6.4" />
      <circle cx="20" cy="46" fill="#f2f5fb" r="6.4" />
      <circle cx="47" cy="10" fill="#060c20" r="3.2" stroke="#9aa5b8" stroke-opacity="0.55" stroke-width="1.6" />

      <circle cx="44" cy="33" fill="url(#t4tLoginMark)" r="10.5" />
    </svg>
    <div class="t4t-logo-word font-bold text-2xl text-center">
      <#nested>
    </div>
  </div>
</#macro>
