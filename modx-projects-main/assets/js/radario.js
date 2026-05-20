(function () {
    if (!window.radario) window.radario = {};
    var radario = window.radario;
  
    if (!radario.Utils) {
      radario.Utils = {};
      radario.Utils.on = function (eventName, element, func) {
        if (window.addEventListener) {
          element.addEventListener(eventName, func, false);
        } else {
          element.attachEvent('on' + eventName, func, false);
        }
      };
  
      radario.Utils.toAbsolutePath = function (opts) {
        var options = opts || {};
        var protocol = options.protocol || 'https';
        var domain = options.domain || 'radario.ru';
        domain = domain.replace('/', '');
  
        return protocol + '://' + domain + options.relative;
      };
  
      radario.Utils.pushUrl = function (opts) {
        if (radario.Widgets.restrictHash) {
          return;
        }
        var options = opts || {};
        if (window.history && window.history.pushState) {
          window.history.pushState(
            null,
            document.title,
            window.location.pathname +
              window.location.search +
              (options.hash || '')
          );
        } else {
          window.location.hash = options.hash;
        }
      };
      radario.Utils.checkMobileOS = {
        Android: function () {
          return !!navigator.userAgent.match(/Android/i);
        },
        BlackBerry: function () {
          return !!navigator.userAgent.match(/BlackBerry/i);
        },
        iOS: function () {
          return !!navigator.userAgent.match(/iPhone|iPad|iPod/i);
        },
        Windows: function () {
          return !!navigator.userAgent.match(/IEMobile/i);
        },
        any: function () {
          return (
            this.Android() || this.iOS() || this.BlackBerry() || this.Windows()
          );
        },
      };
  
      radario.Utils.getColorByBgColor = function (bgColor) {
        if (!bgColor || bgColor.indexOf('#') === -1) {
          return '#000';
        }
        var color = bgColor.replace('#', '');
        if (color.length === 3) {
          color = color[0] + color[0] + color[1] + color[1] + color[2] + color[2];
        }
        return parseInt(color, 16) > 0xffffff / 2 ? '#000' : '#fff';
      };
      radario.Utils.Uri = {};
      radario.Utils.Uri.delimeters = {
        parameter: '&',
        keyValue: '=',
      };
      radario.Utils.Uri.parseCurrentUtm = function () {
        var queryObj = radario.Utils.Uri.parseCurrentParameters({
          toLowerCase: true,
        });
        return {
          UtmSource: queryObj.utm_source,
          UtmMedium: queryObj.utm_medium,
          UtmCampaign: queryObj.utm_campaign,
          UtmContent: queryObj.utm_content,
          UtmTerm: queryObj.utm_term,
        };
      };
      radario.Utils.Uri.parseCurrentParameters = function (opts) {
        var options = opts || { toLowerCase: false };
        var parsedQuery = radario.Utils.Uri.parseQueryString(
          window.location.search
        );
        if (options.toLowerCase) {
          Object.keys(parsedQuery).forEach(function (key) {
            var k = key.toLowerCase();
            if (k !== key) {
              parsedQuery[k] = parsedQuery[key];
              delete parsedQuery[key];
            }
          });
        }
        return parsedQuery;
      };
      radario.Utils.Uri.parseQueryString = function (queryString) {
        var result = {};
        if (queryString) {
          var preparedQueryString =
            queryString.substr(0, 1) === '?'
              ? queryString.substr(1)
              : queryString;
          var splittedQueryString = preparedQueryString.split(
            radario.Utils.Uri.delimeters.parameter
          );
          splittedQueryString.forEach(function (item) {
            if (!item) return;
  
            var pair = radario.Utils.Uri.parseKeyValueString(item);
  
            if (pair.key && pair.value) result[pair.key] = pair.value;
          }, this);
        }
  
        return result;
      };
      radario.Utils.Uri.parseKeyValueString = function (keyValueString) {
        var splitted = keyValueString.split(
          radario.Utils.Uri.delimeters.keyValue
        );
        return {
          key: splitted[0],
          value: splitted[1],
        };
      };
      radario.Utils.getUtmQuery = function (params) {
        var queryUtm = '';
        for (var key in params.utmData) {
          var field = params.utmData[key];
          if (field) {
            queryUtm +=
              '&' +
              key.replace(/([a-z0-9])([A-Z])/g, '$1_$2').toLowerCase() +
              '=' +
              field;
          }
        }
        if (params.utmFromCookie) {
          var customUtm = {};
          params.utmFromCookie.forEach(function (cookie) {
            var foundValue = radario.Utils.getCookie(cookie);
            if (foundValue) {
              queryUtm += '&' + cookie + '=' + foundValue;
              customUtm[cookie] = foundValue;
            }
          });
          params.customGtm = customUtm;
        }
        delete params.utmData;
        delete params.utmFromCookie;
        return queryUtm;
      };
      radario.Utils.getCookie = function (name) {
        var matches = document.cookie.match(
          new RegExp(
            '(?:^|; )' +
              name.replace(/([\.$?*|{}\(\)\[\]\\\/\+^])/g, '\\$1') +
              '=([^;]*)'
          )
        );
        return matches ? decodeURIComponent(matches[1]) : undefined;
      };
      radario.Utils.setCookie = function (name, value, opts) {
        var options = opts || {};
        var expDate = options.expires ? new Date(options.expires) : new Date();
        if (!options.expires) {
          expDate.setFullYear(expDate.getFullYear() + 1);
        }
        expDate = expDate.toUTCString();
        options.path = options.path || '/';
        options.expires = expDate;
  
        var updatedCookie =
          encodeURIComponent(name) + '=' + encodeURIComponent(value);
        for (var optionKey in options) {
          updatedCookie += '; ' + optionKey;
          var optionValue = options[optionKey];
          if (optionValue !== true) {
            updatedCookie += '=' + optionValue;
          }
        }
        document.cookie = updatedCookie;
      };
      radario.Utils.deleteCookie = function (name) {
        radario.Utils.setCookie(name, '', {
          'max-age': -1,
        });
      };
    }
  
    if (!radario.Widgets) {
      radario.Widgets = {};
      radario.Widgets.restrictHash = false;
      radario.Widgets.eventsByLink = {};
      radario.Widgets.count = 0;
      radario.Widgets.store = {};
      radario.Widgets.defaultParams = {};
      radario.Widgets.widgetTypes = {
        afisha: 'Afisha',
        event: 'Event',
        userProfile: 'UserProfile',
      };
      radario.Widgets.openedWidget = false;
  
      radario.Widgets.setDefaultParams = function (opts) {
        var params;
        try {
          params = JSON.parse(JSON.stringify(opts));
        } catch (err) {
          params = {};
          console.error(
            'radario.Widgets.setDefaultParams: params are not valid!'
          );
        }
        radario.Widgets.defaultParams = params;
      };
  
      radario.Widgets.UserProfile = function (opts) {
        if (!document.body) {
          setTimeout(function () {
            radario.Widgets.UserProfile(opts);
          }, 10);
          return;
        }
        var options = opts || {};
        options.widgetId = ++radario.Widgets.count;
        options.openPopUp = true;
        options.createIframe = true;
        var params =
          options.params ||
          JSON.parse(JSON.stringify(radario.Widgets.defaultParams)) ||
          {};
        options.params = params;
        params.hostId = options.hostId || '';
        params.widgetId = options.widgetId;
        options.widgetFrameUrl = radario.Widgets.getWidgetUrl(
          options,
          radario.Widgets.widgetTypes.userProfile
        );
        options.createCloseButton =
          typeof options.createCloseButton !== 'undefined'
            ? options.createCloseButton
            : true;
  
        radario.Widgets.eventsByLink[options.elementHref] = options;
  
        radario.Widgets.store[options.widgetId] = options;
  
        if (document.location.hash === options.elementHref || radario.Widgets.openedWidget) {
          radario.Widgets._constructor(
            options,
            radario.Widgets.widgetTypes.userProfile
          );
          radario.Widgets.openedWidget = false;
        }
      };
  
      radario.Widgets.Event = function (opts) {
        if (!document.body) {
          setTimeout(function () {
            radario.Widgets.Event(opts);
          }, 10);
          return;
        }
  
        var options = opts || {};
        var params =
          options.params ||
          JSON.parse(JSON.stringify(radario.Widgets.defaultParams)) ||
          {};
        options.params = params;
        if (!options.eventId) {
          console.error(
            'radario.Widgets.Event: missing important option - eventId!'
          );
          return;
        }
  
        if (options.createButton && !options.standalone) {
          options.elementHref = options.elementHref
            ? options.elementHref
            : '#event/' + options.eventId;
          radario.Widgets._createButton(options, params);
        }
  
        radario.Widgets._initBaseOptions(options, params);
        params.eventId = options.eventId;
        options.widgetFrameUrl = radario.Widgets.getWidgetUrl(
          options,
          radario.Widgets.widgetTypes.event
        );
  
        radario.Widgets.store[options.widgetId] = options;
        radario.Widgets.eventsByLink[options.elementHref] = options;
  
        if (
          document.location.hash === options.elementHref ||
          options.standalone || radario.Widgets.openedWidget
        ) {
          radario.Widgets._constructor(
            options,
            radario.Widgets.widgetTypes.event
          );
          radario.Widgets.openedWidget = false;
        }
      };
  
      radario.Widgets.initWidget = function (href, { key, id, type }) {
        console.log('href=', href);
        console.log('key=', key);
        console.log('=id', id);
        console.log('=type', type);

        const initWidgetData = {};
        initWidgetData[key] = id;
        initWidgetData['elementHref'] = href;
        if (!radario.Widgets.eventsByLink[href]) {
          radario.Widgets.openedWidget = true;
          radario.Widgets[type](initWidgetData);
        }
      };
  
      radario.Widgets.Afisha = function (opts) {
        if (!document.body) {
          setTimeout(function () {
            radario.Widgets.Afisha(opts);
          }, 10);
          return;
        }
  
        var options = opts || {};
        console.log('opts=', opts);
        var params =
          options.params ||
          JSON.parse(JSON.stringify(radario.Widgets.defaultParams)) ||
          {};
        options.params = params;
        if (!options.key) {
          console.error('radario.Widgets.Afisha: missing required option - key');
          return;
        }
  
        if (options.createButton && !options.standalone) {
          options.elementHref = options.elementHref
            ? options.elementHref
            : '#afisha/' + options.key;
          radario.Widgets._createButton(options, params);
        }
  
        radario.Widgets._initBaseOptions(options, params);
        params.key = options.key;
  
        console.log('KEY=', options.key);
        options.widgetFrameUrl = radario.Widgets.getWidgetUrl(
          options,
          radario.Widgets.widgetTypes.afisha
        );
  
        radario.Widgets.store[options.widgetId] = options;
        radario.Widgets.eventsByLink[options.elementHref] = options;
  
        if (
          document.location.hash === options.elementHref ||
          options.standalone || radario.Widgets.openedWidget
        ) {
          radario.Widgets._constructor(
            options,
            radario.Widgets.widgetTypes.afisha
          );
          radario.Widgets.openedWidget = false;
        }
      };
  
      radario.Widgets.getWidgetUrl = function (opts, type) {
        var srcType = type || radario.Widgets.widgetTypes.event;
        var options = opts || {};
        var srcToReturn = '';
        var utmQuery = radario.Utils.getUtmQuery(options.params);
        var paramsString = JSON.stringify(options.params);
        switch (srcType) {
          case radario.Widgets.widgetTypes.event: {
            srcToReturn =
              '/customer/event/' +
              options.eventId +
              '/info?distributionType=' +
              options.params.distributionType +
              utmQuery +
              '#' +
              paramsString;
            break;
          }
          case radario.Widgets.widgetTypes.afisha: {
            srcToReturn =
              '/customer/afisha/' +
              options.key +
              '?distributionType=' +
              options.params.distributionType +
              utmQuery +
              '#' +
              paramsString;
            break;
          }
          case radario.Widgets.widgetTypes.userProfile: {
            srcToReturn =
              '/widgets/userProfile?distributionType=' +
              options.params.distributionType +
              utmQuery +
              '#' +
              paramsString;
            break;
          }
        }
        return radario.Utils.toAbsolutePath({
          relative: srcToReturn,
          domain: options.domain || radario.Widgets.defaultParams.domain,
          protocol: options.protocol || radario.Widgets.defaultParams.protocol,
        });
      };
  
      radario.Widgets._resize = function (opts) {
        var options = opts || {};
        var width = options.width;
        var height = options.height;
  
        var iframe = document.getElementById('RadarioIframe' + options.widgetId);
        if (!iframe) return;
        if (options.isPopUp) {
          var popupBody = document.getElementById(
            'radarioWidgetPopup' + options.widgetId
          );
          if (popupBody) {
            if (options.fullScreen) {
              var backgroundColor = radario.Widgets.store[options.widgetId].params
                ? radario.Widgets.store[options.widgetId].params.backgroundColor
                : '#fff';
              var closeColor = radario.Utils.getColorByBgColor(backgroundColor);
              var closeButton = document.getElementById(
                'radarioWidgetCloseButton' + options.widgetId
              );
              if (closeButton) {
                closeButton.style.color = closeColor;
              }
            }
            popupBody.classList.toggle('full-screen', !!options.fullScreen);
          }
        }
  
        if (options.fullScreen) {
          height = '100%';
          width = '100%';
        }
        if (width) {
          iframe.style.width = width;
        }
  
        if (height) {
          iframe.style.height = height;
        }
      };
  
      radario.Widgets._preloader = function (opts) {
        var options = opts || {};
        options.obj.classList.toggle('radario-preloader-parent', options.enabled);
        if (!options.enabled) {
          var loader = options.obj.getElementsByClassName(
            'radario-preloader-cont'
          )[0];
          options.obj.removeChild(loader);
          return;
        }
  
        var preloaderCont = document.createElement('div');
        preloaderCont.className = 'radario-preloader-cont';
  
        var preloader = document.createElement('div');
        preloader.className = 'radario-preloader';
  
        if (options.params && options.params.accentColor) {
          preloader.style.borderTopColor = options.params.accentColor;
        }
  
        preloaderCont.appendChild(preloader);
        options.obj.appendChild(preloaderCont);
      };
  
      radario.Widgets._createIframe = function (opts) {
        var options = opts || {};
  
        var obj;
        if (options.openPopUp) {
          obj = document.getElementById('radarioWidgetInner' + options.widgetId);
        } else {
          if (options.appendId) {
            obj = document.getElementById(options.appendId);
          } else {
            obj = document.createElement('div');
            obj.id = 'radarioWidgetInner' + options.widgetId;
            var contChild =
              document.currentScript ||
              (function () {
                var scripts = document.getElementsByTagName('script');
                return scripts[scripts.length - 1];
              })();
            contChild.parentElement.appendChild(obj);
            obj.style.width = options.width || 'auto';
            obj.style.display = 'block';
          }
        }
  
        if (!obj) {
          throw Error('radario.Widgets: cannot find parent for Iframe');
        }
  
        if (!options.no_preloader) {
          radario.Widgets._preloader({
            params: opts.params,
            obj: obj,
            enabled: true,
          });
        }
  
        var iframe = document.createElement('iframe');
        iframe.id = 'RadarioIframe' + options.widgetId;
        iframe.className = options.openPopUp
          ? 'radario-widget-iframe radario-widget-iframe_popup'
          : 'radario-widget-iframe radario-widget-iframe_standalone';
        iframe.frameBorder = 'no';
        iframe.style.border = '0';
        iframe.style.display = 'block';
        iframe.style.zIndex = '10';
        iframe.style.overflow = 'hidden';
        iframe.style.width = options.fullScreen
          ? '100%'
          : options.width || '100px';
        iframe.style.height = options.height || '100px';
        iframe.style.background = options.backgroundColor || 'transparent';
        iframe.src = options.widgetFrameUrl;
  
        obj.appendChild(iframe);
      };
  
      radario.Widgets._createButton = function (opts, param) {
        var params = param || {};
        var options = opts || {};
  
        var locale = options.params.locale || 'ru';
        var link = document.createElement('a');
        link.className = 'radario-button radario-button__main';
        link.href = options.elementHref;
        link.innerHTML =
          (!!options.buttonText && options.buttonText) || radario.Widgets.translateJSON['buyTicket'][locale];
        if (options.buttonFontSize) {
          link.style.fontSize = options.buttonFontSize;
        }
        if (options.buttonPadding) {
          link.style.padding = options.buttonPadding;
        }
        if (options.buttonBorderRadius) {
          link.style.borderRadius = options.buttonBorderRadius;
        }
  
        if (params.accentColor) {
          link.style.background = params.accentColor;
        }
  
        if (options.appendId) {
          var appendItem = document.getElementById(options.appendId);
          appendItem.appendChild(link);
        } else {
          var currentScript =
            document.currentScript ||
            (function () {
              var scripts = document.getElementsByTagName('script');
              return scripts[scripts.length - 1];
            })();
          currentScript.parentElement.appendChild(link);
        }
      };
  
      radario.Widgets._openPopUp = function (opts) {
        var options = opts || {};
        if (!options.widgetId) {
          return;
        }
        var widgetOptions = radario.Widgets.store[options.widgetId];
        if (radario.Utils.checkMobileOS.iOS()) {
          var el = document.scrollingElement || document.documentElement;
          widgetOptions.scrollTop = el.scrollTop;
          document.body.style.position = 'fixed';
        }
        var popupBody = document.createElement('div');
        popupBody.classList.add(
          'radario-popup-body',
          'radario-popup-body_justify-center'
        );
        if (options.removeVerticalCentering) {
          popupBody.classList.remove('radario-popup-body_justify-center');
        }
        popupBody.id = 'radarioWidgetPopup' + options.widgetId;
  
        var popupInner = document.createElement('div');
        popupInner.className = 'radario-popup-inner';
        popupInner.id = 'radarioWidgetInner' + options.widgetId;
  
        if (options.createCloseButton) {
          var popupCloseButton = document.createElement('div');
          popupCloseButton.className = 'radario-close-button';
          popupCloseButton.id = 'radarioWidgetCloseButton' + options.widgetId;
          popupBody.appendChild(popupCloseButton);
        }
        popupBody.appendChild(popupInner);
        document.body.appendChild(popupBody);
        document.body.style.overflow = 'hidden';
        if (!options.fullScreen) {
          radario.Utils.on('scroll', popupBody, radario.Widgets._onScroll);
        }
      };
  
      radario.Widgets.translateJSON = {
        closeMsg: {
          am: 'Վստա՞հ եք, որ ցանկանում եք փակել պատուհանը',
          ru: 'Вы уверены, что хотите закрыть окно?',
          en: 'Are you sure you want to close the window?',
          it: 'Sei sicuro di voler chiudere la finestra?',
          de: 'Möchten Sie das Fenster schließen?',
          es: 'Usted está seguro de que desea cerrar la ventana?',
          pt: 'Você tem certeza de que deseja fechar a janela?',
          fr: 'Voulez-vous fermer la fenêtre?',
          et: 'Olete kindel, et soovite sulgeda aken?',
          fi: 'Oletko varma, että haluat sulkea ikkunan?',
        },
        yes: {
          am: 'Այո',
          ru: 'Да',
          en: 'Yes',
          it: 'Sì',
          de: 'Ja',
          es: 'Sí',
          pt: 'Sim',
          fr: 'Oui',
          et: 'Jah',
          fi: 'Kyllä',
        },
        cancel: {
          am: 'Չեղարկել',
          ru: 'Отмена',
          en: 'Cancel',
          it: 'La cancellazione',
          de: 'Abbrechen',
          es: 'La cancelación de',
          pt: 'Cancelamento',
          fr: 'L\'annulation de la',
          et: 'Tühistamine',
          fi: 'Peruuta',
        },
        buyTicket: {
          am: 'Գնել տոմս',
          ru: 'Купить билет',
          en: 'Buy Ticket',
          it: 'Acquista biglietto',
          de: 'Ticket kaufen',
          es: 'Comprar boleto',
          pt: 'Comprar bilhete',
          fr: 'Acheter un billet',
          et: 'Osta pilet',
          fi: 'Osta lippu'
        }
      };
  
      radario.Widgets._createCloseConfirm = function (opts) {
        var options = opts || {};
        if (!options.widgetId) return;
        var RU = 'ru';
        var EN = 'en';
        var locale = options.params.locale || RU;
        locale = locale.toLowerCase();
        var color =
          options.params && options.params.accentColor
            ? options.params.accentColor
            : '#1786f9';
        var container = document.getElementById(
          'radarioWidgetPopup' + options.widgetId
        );
  
        var wrapperClosePopup = document.createElement('div');
        var titleClosePopup = document.createElement('p');
        var buttonsWrapper = document.createElement('div');
        var buttonConfirm = document.createElement('span');
        var buttonCancel = document.createElement('span');
  
        wrapperClosePopup.classList.add('close-popup-radario');
        titleClosePopup.classList.add(
          'close-popup-radario__title',
          'text-radario'
        );
        buttonsWrapper.classList.add('close-popup-radario__buttons-wrapper');
        buttonConfirm.classList.add('radario-button', 'radario-button__main');
        buttonCancel.classList.add('radario-button');
        titleClosePopup.textContent =
          radario.Widgets.translateJSON['closeMsg'][locale] ||
          radario.Widgets.translateJSON['closeMsg'][EN];
        buttonConfirm.textContent =
          radario.Widgets.translateJSON['yes'][locale] ||
          radario.Widgets.translateJSON['yes'][EN];
        buttonCancel.textContent =
          radario.Widgets.translateJSON['cancel'][locale] ||
          radario.Widgets.translateJSON['cancel'][EN];
        buttonConfirm.style.background = color;
        buttonConfirm.setAttribute('data-radario-close-ok', true);
        buttonConfirm.setAttribute('data-radario-widget-id', options.widgetId);
        buttonCancel.setAttribute('data-radario-close-cancel', true);
  
        buttonsWrapper.appendChild(buttonConfirm);
        buttonsWrapper.appendChild(buttonCancel);
  
        wrapperClosePopup.appendChild(titleClosePopup);
        wrapperClosePopup.appendChild(buttonsWrapper);
  
        container.appendChild(wrapperClosePopup);
      };
  
      radario.Widgets._toggleConfirmClosePopup = function (show, id) {
        var widgetWrapper = document.getElementById('radarioWidgetPopup' + id);
        var closePopup = widgetWrapper.getElementsByClassName(
          'close-popup-radario'
        )[0];
        closePopup.style.display = show ? 'block' : 'none';
      };
  
      radario.Widgets._closePopUp = function (opts) {
        var options = opts || {};
        if (!options.popUpItem && !options.widgetId) return;
        var widgetOptions = radario.Widgets.store[options.widgetId];
        radario.Utils.pushUrl({
          hash: false,
        });
        document.body.style.overflow = '';
        if (radario.Utils.checkMobileOS.iOS()) {
          document.body.style.position = '';
          window.scrollTo(0, widgetOptions.scrollTop);
        }
        if (options.popUpItem) {
          options.popUpItem.parentElement.removeChild(options.popUpItem);
        } else if (options.widgetId) {
          if (typeof widgetOptions.beforeClose === 'function') {
            widgetOptions.beforeClose();
          }
          var popUp = document.getElementById(
            'radarioWidgetPopup' + options.widgetId
          );
          popUp.remove();
        }
      };
  
      radario.Widgets._toggleVisibilityWidget = function (widgetId) {
        if (!widgetId) return;
        var popUp = document.getElementById('radarioWidgetPopup' + widgetId);
        popUp.classList.toggle('radario-hide');
      };
  
      radario.Widgets._constructor = function (opts, widgetType) {
        var options = opts || {};
        if (
          options.params.mobileTarget === '_blank' &&
          radario.Utils.checkMobileOS.any() &&
          !options.standalone
        ) {
          options.params.fullScreen = true;
          var URL = radario.Widgets.getWidgetUrl(options, widgetType);
          if (window === top) {
            var params =
              'menubar=yes,location=yes,resizable=yes,scrollbars=yes,status=yes';
            var open = top.open(URL, '_blank', params);
            if (open == null || typeof open == 'undefined') {
              top.location = URL;
            }
          } else {
            top.location = URL;
          }
          top.location.hash = '';
          return;
        }
  
        if (options.openPopUp) {
          radario.Widgets._openPopUp(options);
          radario.Widgets._createCloseConfirm(options);
        }
  
        if (options.createIframe) {
          radario.Widgets._createIframe(options);
        }
      };
      radario.Widgets._warmingUp = function () {
        if (document.location.hash !== '') {
          return;
        }
        if (!document.body) {
          setTimeout(function () {
            radario.Widgets._warmingUp();
          }, 10);
          return;
        }
        var div = document.createElement('div');
        var iframe = document.createElement('iframe');
        iframe.style.border = '0';
        iframe.style.display = 'block';
        iframe.style.zIndex = '-1';
        iframe.style.overflow = 'hidden';
        iframe.style.position = 'fixed';
        iframe.style.top = '-10000px';
        iframe.style.left = '-10000px';
        iframe.style.width = '1px';
        iframe.style.height = '1px';
        iframe.src = radario.Utils.toAbsolutePath({
          relative: '/company/login',
          domain: radario.Widgets.defaultParams.domain,
          protocol: radario.Widgets.defaultParams.protocol,
        });
        div.appendChild(iframe);
        document.body.appendChild(div);
        setTimeout(function () {
          document.body.removeChild(div);
        }, 30 * 1000);
      };
  
      radario.Widgets._clickListener = function (event) {
        var deep = 5;
        var deepLevel = 0;
        var el = event.target;
  
        var href, className;
        var currentHash = window.location.hash;
        for (var i = 0; el && deepLevel < deep; i++) {
          href = el.getAttribute('href');
          className = el.className;
          if (href) {
            const widgetData = radario.Widgets.getWidgetDataFromHash(href);
            if (radario.Widgets.eventsByLink[href]) {
              radario.Utils.pushUrl({
                hash: href,
              });
              radario.Widgets._constructor(
                radario.Widgets.eventsByLink[href],
                widgetData
              );
              event.preventDefault && event.preventDefault();
              event.stopPropagation && event.stopPropagation();
              return;
            } else {
              widgetData && radario.Widgets.initWidget(href, widgetData);
            }
          }
  
          if (
            typeof className === 'string' &&
            ((className.indexOf('radario-popup-body') !== -1 && deepLevel === 0) ||
              className.indexOf('radario-close-button') !== -1)
          ) {
            if (className.indexOf('radario-close-button') !== -1) {
              el = el.parentElement;
            }
            radario.Widgets._toggleConfirmClosePopup(
              true,
              radario.Widgets.eventsByLink[currentHash].widgetId
            );
          }
  
          if (el.getAttribute('data-radario-close-ok')) {
            radario.Widgets._closePopUp({
              widgetId: el.getAttribute('data-radario-widget-id'),
            });
          } else if (el.getAttribute('data-radario-close-cancel')) {
            radario.Widgets._toggleConfirmClosePopup(
              false,
              radario.Widgets.eventsByLink[currentHash].widgetId
            );
          }
  
          el = el.parentElement;
          deepLevel++;
        }
      };
  
      radario.Widgets._initBaseOptions = function (options, params) {
        options.widgetId = ++radario.Widgets.count;
        options.width =
          options.width ||
          (radario.Utils.checkMobileOS.any() ? '100%' : '1024px');
        params.widgetId = options.widgetId;
        options.openPopUp = !options.standalone || false;
        params.isPopUp = options.openPopUp;
        options.removeVerticalCentering = true;
        options.createIframe = true;
        params.distributionType = params.distributionType
          ? params.distributionType
          : 'Widget';
        options.createCloseButton =
          typeof options.createCloseButton !== 'undefined'
            ? options.createCloseButton
            : true;
        options.backgroundColor = undefined; //params.backgroundColor ? params.backgroundColor : '#fff';
  
        if (!options.standalone) {
          params.fullScreen =
            !!options.fullScreen ||
            radario.Utils.checkMobileOS.any() ||
            window.innerWidth < parseInt(options.width);
          options.fullScreen = params.fullScreen;
        }
        params.utmData = params.utmData
          ? params.utmData
          : radario.Utils.Uri.parseCurrentUtm();
      };
  
      radario.Widgets._onMessage = function (event) {
        if (!event.data.radarioApi2) return;
        var widgetId = event.data.widgetId;
        if (event.data.preloader) {
          var iframe = document.getElementById('RadarioIframe' + widgetId);
          var widgetParams = radario.Widgets.store[widgetId].params;
          var el = iframe.parentNode;
          radario.Widgets._preloader({
            obj: el,
            enabled: event.data.togglePreloader,
            params: widgetParams,
          });
          iframe.style.background = '#fff';
        }
        if (event.data.closePopup) {
          radario.Widgets._closePopUp({
            widgetId: widgetId,
          });
        }
        if (event.data.reloadWidget) {
          radario.Widgets._reloadWidget(widgetId);
        }
        var getBottomCoordinate = function () {
          if (!radario.Widgets.store[widgetId]) return;
          var target = radario.Widgets.store[widgetId].openPopUp
            ? document.getElementById('radarioWidgetPopup' + widgetId)
            : document;
          radario.Widgets._onScroll({ target: target });
        };
        if (event.data.resize) {
          radario.Widgets._resize(event.data);
          getBottomCoordinate();
        }
        if (event.data.openEvent) {
          var eventId = event.data.eventId;
          var beforeClose = function () {};
  
          var afishaOptions = radario.Widgets.store[widgetId];
          var eventOptions = afishaOptions
            ? JSON.parse(JSON.stringify(afishaOptions))
            : { params: {} };
  
          if (afishaOptions) {
            if (!afishaOptions.standalone) {
              radario.Widgets._toggleVisibilityWidget(afishaOptions.widgetId);
            }
            beforeClose = function () {
              if (typeof afishaOptions.beforeClose === 'function') {
                afishaOptions.beforeClose();
              }
              if (!afishaOptions.standalone) {
                window.location.hash = afishaOptions.elementHref;
                radario.Widgets._toggleVisibilityWidget(afishaOptions.widgetId);
              }
            };
          }
          var hash = '#event/' + eventId;
          eventOptions.elementHref = hash;
          window.location.hash = hash;
          eventOptions.params.fullScreen = '';
          eventOptions.standalone = false;
          eventOptions.width = null;
          eventOptions.createButton = false;
          var createOptions = Object.assign(eventOptions, {
            eventId: eventId,
            beforeClose: beforeClose,
          });
          radario.Widgets.Event(createOptions);
        }
  
        if (event.data.getWidgetParams) {
          var getSourceIframe = function (event) {
            var sourceFrame = null;
            var iframes = document.getElementsByClassName(
              'radario-widget-iframe'
            );
            if (iframes) {
              for (var item of iframes) {
                if (
                  item.contentWindow === event.source ||
                  item.contentWindow === event.source.parent
                ) {
                  sourceFrame = item;
                  break;
                }
              }
              if (!sourceFrame) {
                for (item of iframes) {
                  if (item.src.indexOf(event.origin) === 0) {
                    sourceFrame = item;
                    break;
                  }
                }
              }
            }
            return sourceFrame;
          };
  
          var sourceIframe = getSourceIframe(event);
          if (sourceIframe) {
            var sourceIframeId = sourceIframe.id;
            var sourceIframeWidgetId = +sourceIframeId.replace(
              'RadarioIframe',
              ''
            );
  
            sourceIframe.contentWindow.postMessage(
              {
                radarioApi2: true,
                type: 'setWidgetParams',
                params: radario.Widgets.store[sourceIframeWidgetId],
              },
              '*'
            );
          }
        }
      };
  
      radario.Widgets._onScroll = function (event) {
        if (!event.target) return;
        var target = event.target.scrollingElement
          ? event.target.scrollingElement
          : event.target;
        var scrollTop = target.scrollTop;
        var classSelector =
          event.target === document
            ? 'radario-widget-iframe_standalone'
            : 'radario-widget-iframe_popup';
        var iframes = target.getElementsByClassName(classSelector);
  
        function getOffsetSum (elem, endElem) {
          var top = 0;
          while (elem && elem !== endElem) {
            top = top + parseFloat(elem.offsetTop);
            elem = elem.offsetParent;
          }
          return Math.round(top);
        }
  
        for (var item of iframes) {
          var offset = getOffsetSum(item);
          var iframeHeight = item.clientHeight + offset;
          var windowHeight = window.innerHeight;
          var bottom = Math.round(iframeHeight - windowHeight - scrollTop);
          var top = scrollTop - offset >= 0 ? scrollTop - offset : 0;
          if (bottom < iframeHeight) {
            item.contentWindow.postMessage(
              {
                radarioApi2: true,
                type: 'positions',
                height: iframeHeight,
                bottom: bottom,
                top: top,
                middle: Math.round((top + windowHeight) / 2),
              },
              '*'
            );
          }
        }
      };
  
      radario.Widgets._reloadWidget = function (widgetId) {
        if (!widgetId) return;
        var iframe = document.getElementById('RadarioIframe' + widgetId);
        iframe.src = iframe.src;
      };
  
      radario.Widgets.getWidgetDataFromHash = function (href) {
        if (!href) return;
        const checkUrls = [
          {
            type: radario.Widgets.widgetTypes.event,
            url: '#event/',
            key: 'eventId',
          },
          {
            type: radario.Widgets.widgetTypes.afisha,
            url: '#afisha/',
            key: 'key',
          },
        ];
        let data = {};
        if (!radario.Widgets.eventsByLink[href]) {
          data = checkUrls.find(value => href.indexOf(value.url) === 0);
          if (!data) return;
          data.id = href.split(data.url)[1];
          data.url = href;
        } else {
          const currentId = radario.Widgets.eventsByLink[href].eventId || radario.Widgets.eventsByLink[href].key;
          const currentType = radario.Widgets.eventsByLink[href].eventId
            ? radario.Widgets.widgetTypes.event
            : radario.Widgets.widgetTypes.afisha;
          const currentKey = radario.Widgets.eventsByLink[href].eventId ? 'eventId' : 'key';
          data = {
            key: currentKey,
            type: currentType,
            url: href,
            id: currentId
          };
        }
        return {
          key: data.key,
          id: data.id,
          type: data.type || '',
          url: data.url || ''
        };
      };
  
      radario.Utils.on('click', document, radario.Widgets._clickListener);
  
      radario.Utils.on('message', window, radario.Widgets._onMessage);
  
      radario.Utils.on('scroll', document, radario.Widgets._onScroll);
  
      setTimeout(function () {
        const widgetData = radario.Widgets.getWidgetDataFromHash(document.location.hash);
        widgetData && radario.Widgets.initWidget(document.location.hash, widgetData);
  
        if (!document.getElementById('radarioWidgetStyles')) {
          var styles = document.createElement('link');
          styles.id = 'radarioWidgetStyles';
          styles.rel = 'stylesheet';
          styles.href = radario.Utils.toAbsolutePath({
            relative: '/frontend/src/assets/styles/widget/widget-styles.css',
            domain: radario.Widgets.defaultParams.domain,
            protocol: radario.Widgets.defaultParams.protocol,
          });
          document.head.appendChild(styles);
        }
      }, 100);
  
      radario.Widgets._warmingUp();
    }
  })(window);