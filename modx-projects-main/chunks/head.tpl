{var $resourceId = 'id' | resource}

<head>
    <base href="[[!++site_url]]">
    <meta charset="utf-8">
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta name="format-detection" content="telephone=no">
    
    <meta name="pagetemplate" content="{$_modx->resource.template}">
    <meta name="pageid" content="{$_modx->resource.id}">
    <meta name="pageparent" content="{$_modx->resource.parent}">
    
    <meta property="og:title" content="[[*longtitle]]" />
    <meta property="og:type" content="article" />
    <meta property="og:url" content="" />
    <meta property="og:image" content="" />
    <meta property="og:site_name" content="Riversales" />
    
    <title>[[*longtitle]]</title>
    <meta name="description" content="[[*description]]">
    
    {var $canonical = $_modx->resource.canonical}
    {if $canonical}
        <link rel="canonical" href="{$canonical}" />
    {/if}
    
    {'!regCss' | snippet : ['assets_css_path' => 'assets/css/']}
    
    <link rel="icon" href="/favicon.svg" type=" image/svg+xml">
    <link rel="stylesheet" href="/assets/css/normalize.css">
    <link rel="stylesheet" href="/assets/css/main.css?v{time()}">
    <link rel="stylesheet" href="/assets/fonts/Roboto/stylesheet.css">
    <link rel="stylesheet" href="/assets/vendor/swiper/swiper-bundle.min.css">
    <link rel="stylesheet" href="/assets/vendor/hystmodal/hystmodal.min.css">
    <link rel="stylesheet" href="/assets/vendor/simplebar/simplebar.min.css">
    <link rel="stylesheet" href="/assets/vendor/glightbox/glightbox.min.css">
    <link rel="stylesheet" href="//s3.intickets.ru/intickets.min.css">
    <script src="//s3.intickets.ru/intickets.js"></script>
    <script src="https://radario.ru/frontend/src/api/openapi/openapi.js"></script>

    
    <noscript><div><img src="https://mc.yandex.ru/watch/88955648" style="position:absolute; left:-9999px;" alt="" /></div></noscript>
    <meta name="yandex-verification" content="c0060d2680cca0c7" /> 
    <meta name="google-site-verification" content="JAlukmVxF_uHLKF4C0gTRzbg799o3Yz2DlwTWnY7kgY" />
    
    <noscript><iframe src="https://www.googletagmanager.com/ns.html?id=GTM-T6NRDH4"
    height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>
    
    <!-- Yandex.Metrika counter -->
    <script type="text/javascript" >
       (function(m,e,t,r,i,k,a){ m[i]=m[i]||function(){ (m[i].a=m[i].a||[]).push(arguments) } ;
       m[i].l=1*new Date();
       for (var j = 0; j < document.scripts.length; j++) { if (document.scripts[j].src === r) { return; } }
       k=e.createElement(t),a=e.getElementsByTagName(t)[0],k.async=1,k.src=r,a.parentNode.insertBefore(k,a) } )
       (window, document, "script", "https://mc.yandex.ru/metrika/tag.js", "ym");
    
       ym(88955648, "init", {
            clickmap:true,
            trackLinks:true,
            accurateTrackBounce:true,
            webvisor:true
       });
    </script>
    <noscript><div><img src="https://mc.yandex.ru/watch/88955648" style="position:absolute; left:-9999px;" alt="" /></div></noscript>
    <!-- /Yandex.Metrika counter -->
    
    <!-- Top.Mail.Ru counter -->
    <script type="text/javascript">
        var _tmr = window._tmr || (window._tmr = []);
        _tmr.push( { id: "3531741", type: "pageView", start: (new Date()).getTime() } );
        (function (d, w, id) {
          if (d.getElementById(id)) return;
          var ts = d.createElement("script"); ts.type = "text/javascript"; ts.async = true; ts.id = id;
          ts.src = "https://top-fwz1.mail.ru/js/code.js";
          var f = function () { var s = d.getElementsByTagName("script")[0]; s.parentNode.insertBefore(ts, s); } ;
          if (w.opera == "[object Opera]") { d.addEventListener("DOMContentLoaded", f, false); } else { f(); }
        })(document, window, "tmr-code");
    </script>
    <noscript><div><img src="https://top-fwz1.mail.ru/counter?id=3531741;js=na" style="position:absolute;left:-9999px;" alt="Top.Mail.Ru" /></div></noscript>
    <!-- /Top.Mail.Ru counter -->
        

    
    <script src="//code.jivo.ru/widget/SmEmQVQqF1" async></script>
</head>