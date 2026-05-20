const phoneMask = '+0(000)000-00-00';
const catalogLoadMoreCount = 9;
const verificationErrorUrl = '/verification-error';
const riverTripTopfixedBar = document.querySelector('.js-river-trip-fixed-bar');

let filterValues = {};
let shipFilterValues = {
  sort: 'menuindex'
};

// ANCHOR - вызов функций   

bindEvents();
setMapsWidgetsDimensions();
setInputMasks();
toggleTopFixedBar();
changeScheduleBtnName();
initPriceFilter();
checkCookies();

//SECTION FUNCTIONS

//ANCHOR - addOnClickListener

function addOnClickListener(selector, func) {
    let element = document.querySelector(selector);
    if (element) {
        element.addEventListener('click', func);
    }
}

//ANCHOR - addOnClickListeners

function addOnClickListeners(selector, func) {
    let elements = document.querySelectorAll(selector);
    if (elements) {
        for (var i=0; i < elements.length; i++) {
            elements[i].addEventListener( "click" , func);
        }
    }
}


///ANCHOR clearNumber

function clearNumber(string, needStringOutput = false) {
  // let clearString = string.replace(/[^0-9]/,"");
  let clearString = string.replace(/\D/g, '');

  if (!needStringOutput) {
    number = Number(clearString);
  } else {
    number = clearString;
  }

  return number;
}

//ANCHOR - changeScheduleBtnName

function changeScheduleBtnName() {
  // Select the node that will be observed for mutations
  const buttons = document.querySelectorAll('.js-schedule-button');

  if (buttons.length == 0) {
    return false;
  }
  // Options for the observer (which mutations to observe)
  const config = { attributes: true, childList: true, subtree: true };

  // Callback function to execute when mutations are observed
  const callback = (mutationList, observer) => {
    for (const mutation of mutationList) {
      
      let btn = mutation.target.querySelector('.ti-tickets-event-tickets-buy');

      if (btn) {
        btn.innerHTML = "Открыть расписание";
        observer.disconnect();
        return false;
      }

    }
  };
  
  buttons.forEach(el => {    
    let observer = new MutationObserver(callback);
    observer.observe(el, config);
  })
}


//ANCHOR - closeFilterItems

function closeFilterItems(event = false) {
  if (event) {
    let isFilter = event.target.closest('.js-filter-item');
  
    if (isFilter) {
      return false;
    }
  }

  let items = document.querySelectorAll('.js-filter-item');
  
  items.forEach(el => {
    el.classList.remove('opened');
  })

  let body = document.querySelector('body');
  body.removeEventListener('click', closeFilterItems);
  
  filterItemsSwiper.enable();
}

//ANCHOR - closeInputLists

function closeInputLists(event = false) {
  
  if (event) {
    let isList = event.target.closest('.js-input-list');
  
    if (isList) {
      return false;
    }
  }

  let items = document.querySelectorAll('.js-form-group');
  
  items.forEach(el => {
    el.classList.remove('opened');
  })

  let body = document.querySelector('body');
  body.removeEventListener('click', closeFilterItems);
}


//ANCHOR - copyToClipboard

function copyToClipboard(event) {

  let btn = event.target;
  let text = btn.dataset.url;

  navigator.clipboard.writeText(text).then(function() {
    
    btn.innerHTML = 'Ссылка скопирована';
    btn.removeEventListener( "click" , copyToClipboard);
    btn.classList.add('done');

    setTimeout(() => {
      btn.innerHTML = 'Скопировать ссылку';
      btn.classList.remove('done');
      addOnClickListener('.js-copy-to-clipboard', copyToClipboard);
    }, 1500);


  }, function(err) {
    console.error('Async: Could not copy text: ', err);
  });

}

//ANCHOR - expandText

function expandDescription(event) {
    let targetButton = event.target;
    let textBlock = document.querySelector('.js-description');

    targetButton.classList.add('js-hidden');
    textBlock.classList.add('expanded');
}

//ANCHOR - math.round10 /.floor10 /.ceil10

(function() {
    /**
     * Корректировка округления десятичных дробей.
     *
     * @param {String}  type  Тип корректировки.
     * @param {Number}  value Число.
     * @param {Integer} exp   Показатель степени (десятичный логарифм основания корректировки).
     * @returns {Number} Скорректированное значение.
     */
    function decimalAdjust(type, value, exp) {
      // Если степень не определена, либо равна нулю...
      if (typeof exp === 'undefined' || +exp === 0) {
        return Math[type](value);
      }
      value = +value;
      exp = +exp;
      // Если значение не является числом, либо степень не является целым числом...
      if (isNaN(value) || !(typeof exp === 'number' && exp % 1 === 0)) {
        return NaN;
      }
      // Сдвиг разрядов
      value = value.toString().split('e');
      value = Math[type](+(value[0] + 'e' + (value[1] ? (+value[1] - exp) : -exp)));
      // Обратный сдвиг
      value = value.toString().split('e');
      return +(value[0] + 'e' + (value[1] ? (+value[1] + exp) : exp));
    }
  
    // Десятичное округление к ближайшему
    if (!Math.round10) {
      Math.round10 = function(value, exp) {
        return decimalAdjust('round', value, exp);
      };
    }
    // Десятичное округление вниз
    if (!Math.floor10) {
      Math.floor10 = function(value, exp) {
        return decimalAdjust('floor', value, exp);
      };
    }
    // Десятичное округление вверх
    if (!Math.ceil10) {
      Math.ceil10 = function(value, exp) {
        return decimalAdjust('ceil', value, exp);
      };
    }
})();


//ANCHOR - navigateMobileMenu

function navigateMobileMenu(event) {
  let targetButton = event.target.closest('.js-mobile-menu-btn');
  let navigateBackButton = document.querySelector('.js-mobile-menu-back-btn');
  let closeMenuButton = document.querySelector('.js-mobile-menu-close-btn');
  let rootLevelItems = document.querySelectorAll('.js-resources-mobile-menu .level1');
  let parentsItems = document.querySelectorAll('.js-mobile-menu-parent');
  let targetInnerItems = targetButton.querySelectorAll('.js-mobile-menu-inner');
  let innerItems = document.querySelectorAll('.js-mobile-menu-inner');

  let isExcursion = targetButton.dataset.type == 'excursion';
  if  (isExcursion) { 
    return false;
  }
  
  console.log('nav', rootLevelItems);
  let isNavigateBackEvent = targetButton.classList.contains('js-mobile-menu-back-btn');
  let isNavigateForwardEvent = targetButton.classList.contains('js-mobile-menu-parent');
  
  if (isNavigateBackEvent) {
    closeMenuButton.classList.remove('js-hidden');
    navigateBackButton.classList.add('js-hidden');

    rootLevelItems.forEach(el => {
      el.classList.remove('js-hidden');
    })

    parentsItems.forEach(el => {
      el.classList.remove('opened');
    })

    innerItems.forEach(el => {
      el.classList.add('js-hidden');
    })
  }

  if (isNavigateForwardEvent) {
    targetButton.classList.add('opened');
    closeMenuButton.classList.add('js-hidden');
    navigateBackButton.classList.remove('js-hidden');

    rootLevelItems.forEach(el => {
      if (el != targetButton) {
        el.classList.add('js-hidden');
      }
    })


    targetInnerItems.forEach(el => {
      el.classList.remove('js-hidden');
    })
  }


}

//ANCHOR - initPriceFilter

function initPriceFilter() {
  const filterItem = document.querySelector('.js-filter-item[data-filter-name="price"]');

  if (!filterItem) {
    return false;
  }

  const rangeInput = document.querySelectorAll(".js-range-input");  
  const priceInput = document.querySelectorAll(".js-price-input");
  const range = document.querySelector(".js-price-progress");

  
  priceInput.forEach((input) => {
    
    input.addEventListener("change", (e) => {
      let globalMin = Number(filterItem.dataset.globalMin);
      let globalMax = Number(filterItem.dataset.globalMax);
      let targetInput = e.target;

      targetInput.value = Number(targetInput.value);

      if (targetInput.value > globalMax) {
        targetInput.value = globalMax;
      }

      if (targetInput.value < globalMin) {
        targetInput.value = globalMin;
      }

      let minPrice = parseInt(priceInput[0].value);
      let maxPrice = parseInt(priceInput[1].value);
  
      if (targetInput.classList.contains("js-input-min")) {
        let fullRange = rangeInput[0].max - rangeInput[0].min;
        let minRange = minPrice - rangeInput[0].min;

        rangeInput[0].value = minPrice;
        range.style.left = (minRange / fullRange) * 100 + "%";

        if (minPrice > maxPrice) {
          priceInput[1].value = minPrice;
          rangeInput[1].value = minPrice;
          range.style.right = 100 - (minRange / fullRange) * 100 + "%";
        }

        if (minPrice == globalMax) {
          rangeInput[0].style.zIndex = 1;
          rangeInput[1].style.zIndex = 0;
        }
      } else {
        let fullRange = rangeInput[0].max - rangeInput[0].min;
        let maxRange = maxPrice - rangeInput[0].min;

        rangeInput[1].value = maxPrice;
        range.style.right = 100 - (maxRange / fullRange) * 100 + "%";

        if (maxPrice < minPrice) {
          priceInput[0].value = maxPrice;
          rangeInput[0].value = maxPrice;

          range.style.left = (maxRange / fullRange) * 100 + "%";

        }

        if (maxPrice == globalMax) {
          rangeInput[0].style.zIndex = 0;
          rangeInput[1].style.zIndex = 1;
        }

      }

      setResult();
    });
  });
  
  rangeInput.forEach((input) => {

    input.addEventListener("pointerdown", (event) => {
      input.setPointerCapture(event.pointerId);
    });

    document.addEventListener("lostpointercapture", setResult);

    input.addEventListener("input", (e) => {
      let globalMin = Number(filterItem.dataset.globalMin);
      let globalMax = Number(filterItem.dataset.globalMax);
      let minVal = parseInt(rangeInput[0].value);
      let maxVal = parseInt(rangeInput[1].value);

      targetInput = e.target;
      let targetIsMin = targetInput.classList.contains('js-range-min');
      let targetIsMax = targetInput.classList.contains('js-range-max');

      if (minVal >= maxVal && targetIsMin) {
        maxVal = minVal;
        rangeInput[1].value = minVal;
        priceInput[0].value = minVal;
        priceInput[1].value = minVal;
      } 
      else if (maxVal <= minVal && targetIsMax) {
        minVal = maxVal;
        rangeInput[0].value = maxVal;
        priceInput[0].value = maxVal;
        priceInput[1].value = maxVal;
      } else {

        priceInput[0].value = minVal;
        priceInput[1].value = maxVal; 
      }

      if (maxVal == globalMin) {
        rangeInput[0].style.zIndex = 0;
        rangeInput[1].style.zIndex = 1;
      }

      if (minVal == globalMax) {
        rangeInput[0].style.zIndex = 1;
        rangeInput[1].style.zIndex = 0;
      }
      
      let fullRange = rangeInput[0].max - rangeInput[0].min;
      let minRange = minVal - rangeInput[0].min;
      let maxRange = maxVal - rangeInput[0].min;

      range.style.left = (minRange / fullRange) * 100 + "%";
      range.style.right = 100 - (maxRange / fullRange) * 100 + "%";

    });
  });

  function setResult(){
    let inputMin = priceInput[0].value;
    let inputMax = priceInput[1].value;

    let currentMin = Number(filterItem.dataset.currentMin);
    let currentMax = Number(filterItem.dataset.currentMax);

    if (inputMin == currentMin && inputMax == currentMax) {
      return false;

    } else {
      filterItem.dataset.currentMin = inputMin;
      filterItem.dataset.currentMax = inputMax;
    }

    rangeInput[1].value = inputMax;

    let output = {
      target: filterItem,
      minPrice: inputMin,
      maxPrice: inputMax
    };
    
  }
}

//ANCHOR - initTeplohodWidgets

function initTeplohodWidgets() {
  let elements = document.querySelectorAll('.nearest-widget-empty');

  let widgets = [];

  for (const el of elements) {
    let widget = el.closest('[data-bind="teplohod-widget-nearest"]');
    loadWidgetContent(widget);
  }

  
  function loadWidgetContent(el) {
    const widgetId = el.dataset.widget_id || '';
    const eventId = el.dataset.event_id || '';
    const date = el.dataset.date || 'nearest';
    const emptyText = el.dataset.emptyText || '';
    const limit = el.dataset.limit || '';

    const url = `https://account.teplohod.info/nearest/load.php?widget_id=${widgetId}&event_id=${eventId}&date=${date}&emptyText=${emptyText}&limit=${limit}`;


    fetch(url)
        .then(res => {
            if (!res.ok) throw new Error('[Widget Nearest]: ÐžÑˆÐ¸Ð±ÐºÐ° Ð·Ð°Ð³Ñ€ÑƒÐ·ÐºÐ¸ Ð²Ð¸Ð´Ð¶ÐµÑ‚Ð° Ð±Ð»Ð¸Ð¶Ð°Ð¹ÑˆÐ¸Ñ… Ñ€ÐµÐ¹ÑÐ¾Ð²');
            return res.text();
        })
        .then(html => {
            el.innerHTML = html;
            el.classList.add('widget-loaded');
        })
        .catch(err => {
            console.error(err);
        });
  }
}



//ANCHOR - openMainGallery

function openMainGallery(event) {
  if (!mainGalleryLightbox) {
    return false;
  }

  let dataElement = event.target.closest('.js-open-main-gallery');
  let slideNumber = dataElement.dataset.slideNumber;

  mainGalleryLightbox.openAt(slideNumber);
}

//ANCHOR - resetForm 

// function resetForm(event) {
//   let form = event.target.closest('form');
//   console.log(form.elements);

//   Array.from(form.elements).forEach(el => {
//     el.value = '';
//     el.checked = false;
//   })
// }


//ANCHOR - removeDoubleSlashes 

function removeDoubleSlashes(text) {
  let firstChars = text.slice(0, 2);

  let resultText = text;

  if (firstChars == '//') {
    resultText = text.slice(1);
  }

  return resultText;
}


//ANCHOR - selectInputList

function selectInputList(event) {
  let selectedValue = event.target.innerHTML;

  let formGroup = event.target.closest('.js-form-group');
  let input = formGroup.querySelector('.js-input');
  let title = formGroup.querySelector('.js-title');

  input.value = selectedValue;
  title.innerHTML = selectedValue;

  closeInputLists();
}


//ANCHOR - setInputMasks
function setInputMasks() {
  let phoneInputs = document.querySelectorAll('input[name="phone"]');
  let priceInputs = document.querySelectorAll('.js-price-input'); 
  let guestsInputs = document.querySelectorAll('input[name="guests"]');
  let hoursInputs = document.querySelectorAll('input[name="hours"]');

  
  const { Mask, MaskInput, vMaska } = Maska;
  
  if (phoneInputs) {
    new MaskInput(phoneInputs, { mask: "+# (###) ###-##-##" })
  }
  
  if (priceInputs) {
    new MaskInput(priceInputs, { mask: "#######" })
  }

  if (guestsInputs) {
    new MaskInput(guestsInputs, { mask: "#####", eager: true })
  }

  if (hoursInputs) {
    new MaskInput(hoursInputs, { mask: "#####", eager: true })
  }
}

//ANCHOR - switchMaps

function switchMaps(event) {
  let targetButton = event.target.closest('.js-switch-maps');
  let mapSection = targetButton.closest('.js-map-section');
  let type = targetButton.getAttribute('data-type');

  if (!type) {
    return false;
  }

  let mapBlocks = mapSection.querySelectorAll('.js-map-block');
  let targetMapBlock = mapSection.querySelector('.js-map-block[data-type="' + type + '"');
  let switchButtons = mapSection.querySelectorAll('.js-switch-maps');
  

  mapBlocks.forEach(el => {
    el.classList.remove('active');
  })

  switchButtons.forEach(el => {
    el.classList.remove('active');
  })

  targetMapBlock.classList.add('active');
  targetButton.classList.add('active');
}

//ANCHOR - toggleInputList

function toggleInputList(event) {

  let targetItem = event.target.closest('.js-form-group');
  let inputItems = document.querySelectorAll('.js-form-group');
  let isOpened = targetItem.classList.contains('opened');
  
  inputItems.forEach(el => {
    el.classList.remove('opened');
  })

  if (!isOpened) {
    targetItem.classList.toggle('opened');
  }

  addOnClickListener('body', closeInputLists);
}

//ANCHOR - toggleAdditionalSection

function setMapsWidgetsDimensions() {
    let routeYaMapsWidget = document.querySelector('.route-section iframe');
    let locationYaMapsWidget = document.querySelector('.location-section iframe');


    if (routeYaMapsWidget) { 
        routeYaMapsWidget.style.height = '340px';
        routeYaMapsWidget.style.width = '340px';
        routeYaMapsWidget.setAttribute("height", 340);
        routeYaMapsWidget.setAttribute("width", 340);
    }

    if (locationYaMapsWidget) { 
        locationYaMapsWidget.style.height = '340px';
        locationYaMapsWidget.style.width = '340px';
        locationYaMapsWidget.setAttribute("height", 340);
        locationYaMapsWidget.setAttribute("width", 340);
    }
}


//ANCHOR - toggleAdditionalSection

function toggleAdditionalSection(event) {
  let section = event.target.closest('.js-river-trip-additional-section');
  let subsection = section.querySelector('.js-can-hide');

  section.classList.toggle('js-opened');
  subsection.classList.toggle('js-hidden');
}

//ANCHOR - toggleBlock

function toggleBlock(event) {   
  let action = event.target.hasAttribute('data-show-button') ? 'show' : 'hide';
  let id = event.target.getAttribute('data-' + action + '-button');

  if (!id) {
    return false;
  }

  let showButtons = document.querySelectorAll('[data-show-button="' + id + '"]');
  let hideButtons = document.querySelectorAll('[data-hide-button="' + id + '"]');
  let hideableBlocks = document.querySelectorAll('[data-hideable-block="' + id + '"]');

  if (action == 'show') {
    showButtons.forEach(el =>{
      if (!el.hasAttribute('always-visible')) {
        el.classList.add('js-hidden');
      }
    })   

    hideButtons.forEach(el =>{
      el.classList.remove('js-hidden');
    })   

    hideableBlocks.forEach(el =>{
      el.classList.remove('js-hidden');
    })

  } else {
    showButtons.forEach(el =>{
      el.classList.remove('js-hidden');
    })   

    hideButtons.forEach(el =>{
      el.classList.add('js-hidden');
    })   

    hideableBlocks.forEach(el =>{
      el.classList.add('js-hidden');
    })
  }
}

//ANCHOR - toggleFilterItem

function toggleFilterItem(event) {
  let targetItem = event.target.closest('.js-filter-item');
  let filterItems = document.querySelectorAll('.js-filter-item');
  let isOpened = targetItem.classList.contains('opened');
  let isSlider = targetItem.classList.contains('swiper-slide');
  
  let itemNumber;
  if (isSlider) {
    itemNumber = Number(targetItem.getAttribute('aria-label').slice(0,1)) - 1;
  }

  filterItems.forEach(el => {
    el.classList.remove('opened');
  })

  if (!isOpened) {
    targetItem.classList.toggle('opened');
    if (isSlider) {
      filterItemsSwiper.enable();
      filterItemsSwiper.slideTo(itemNumber, 0);
      filterItemsSwiper.disable();
    }    
  } else {
    if (isSlider) {
      filterItemsSwiper.enable();
      console.log('swEn');
    }
  }

  addOnClickListener('body', closeFilterItems);
}

//ANCHOR - toggleTopFixedBar

function toggleTopFixedBar() {

  if (!riverTripTopfixedBar) {
    return false;
  }

  let currentPosition = window.scrollY;
  let threshold = 174;

  let barIsHidden = riverTripTopfixedBar.classList.contains('js-hidden');

  if (currentPosition > threshold && barIsHidden) {
    riverTripTopfixedBar.classList.remove('js-hidden');
  } 

  if (currentPosition < threshold && !barIsHidden) {
    riverTripTopfixedBar.classList.add('js-hidden');
  }
}

//ANCHOR - validateForm

function validateForm(form) {
  let hasErrors = false;

  Array.from(form.elements).forEach(el => {
    if (el.tagName != 'INPUT' || !el.classList.contains('required')) {
      return false;
    }

    let formGroup = el.closest('.js-form-group');
    let errorLabel = formGroup.querySelector('.error');
    let valid;
    let errorText;

    switch (el.name) {
      case 'name':
        valid = v8n().not.empty().test(el.value);
        errorText = inputErrors.nameEmpty;
        break;

      case 'phone':
        let phone = clearNumber(el.value, true);
        valid = v8n().not.empty().test(phone);
        errorText = inputErrors.phoneEmpty;

        if (valid) {
          valid = v8n().length(11).test(phone);
          errorText = inputErrors.phoneShort;
        }
        break;

      case 'email':
        valid = v8n().not.empty().test(el.value);
        errorText = inputErrors.emailEmpty;

        if (valid) {
          valid = v8n().pattern(/.+\@.+\..+/).test(el.value);
          errorText = inputErrors.emailWrong;
        }
        break;

      default:
        valid = v8n().not.empty().test(el.value);
        errorText = inputErrors.default;
        break;
    }

    if (!valid) {
      hasErrors = true;
      formGroup.classList.add('error');
      errorLabel.innerHTML = errorText;
    } else {
      formGroup.classList.remove('error');
    }
  });

  let agreementSection = form.querySelector('.js-form-agreement-section');

  if (agreementSection) {
  let isChecked = agreementSection.classList.contains('checked');
  if (!isChecked) {
    agreementSection.classList.add('error');
    hasErrors = true; 
  } else {
    agreementSection.classList.remove('error');
  }
  }

  return hasErrors;
}


//ANCHOR - BIND EVENTS

function bindEvents() {
  
  if (riverTripTopfixedBar) {
      window.addEventListener('resize', toggleTopFixedBar);
      window.addEventListener('scroll', toggleTopFixedBar);
  }

  let shipSearchInput = document.querySelector('.js-ship-search-input');
  if (shipSearchInput) {
    shipSearchInput.addEventListener('change', applyShipFilter);
    shipSearchInput.addEventListener('input', applyShipFilter);
  }

  addOnClickListeners('.js-expand-description', expandDescription);
  addOnClickListener('.js-show-more-reviews', showMoreReviews);
  addOnClickListener('.js-copy-to-clipboard', copyToClipboard);
  addOnClickListener('.js-show-more-catalog-items', showMoreCatalogItems);
  addOnClickListener('.js-mobile-menu-back-btn', navigateMobileMenu);

  
  addOnClickListeners('.js-filter-toggle', toggleFilterItem);
  addOnClickListeners('.js-river-trip-additional-section-toggle', toggleAdditionalSection);
  // addOnClickListeners('.js-send-form', sendForm);
  addOnClickListeners('.js-apply-filter', applyFilter);
  addOnClickListeners('.js-apply-ship-filter', applyShipFilter);
  addOnClickListeners('.js-mobile-menu-parent', navigateMobileMenu);
  addOnClickListeners('.js-open-input-list', toggleInputList);
  addOnClickListeners('.js-select-input-list', selectInputList);
  addOnClickListeners('.js-show-more-articles', showMoreArticles);
  addOnClickListeners('.js-show-more-ships', showMoreShips);
  addOnClickListeners('.js-show-more-piers', showMorePiers);
  addOnClickListeners('[data-show-button], [data-hide-button]', toggleBlock);
  addOnClickListeners('.js-switch-maps', switchMaps);
  addOnClickListeners('.js-reset-form', resetForm);
  addOnClickListeners('.js-open-main-gallery', openMainGallery);
  addOnClickListeners('.js-header-city-selector', toggleCitySelector);
  addOnClickListeners('.js-agreement-btn', toggleAgreement);

}

//!SECTION

///ANCHOR getCoords 
function getCoords(elem) {
  let box = elem.getBoundingClientRect();

  return {
    top: box.top + window.pageYOffset,
    right: box.right + window.pageXOffset,
    bottom: box.bottom + window.pageYOffset,
    left: box.left + window.pageXOffset
  };
}

//SECTION - AJAX

///ANCHOR applyFilter

function applyFilter(event) {
  let filterItem = event.target.closest('.js-filter-item');

  let filterType = filterItem.dataset.filterType;
  let filterName = filterItem.dataset.filterName;
  let isSelected = filterItem.classList.contains('selected');

  let textTagPageIdEl = document.querySelector('.js-text-tag-page');

  if (textTagPageIdEl) {
    filterValues['textTag'] = textTagPageIdEl.dataset.id; 
  }


  if (filterType == 'list') {    
    let filterTitle = filterItem.querySelector('.js-filter-title');
    let filterToggle = filterItem.querySelector('.js-filter-toggle');
    
    if (!isSelected) {
      let targetButton = event.target.closest('.js-apply-filter');
      let valueName = targetButton.innerHTML;
      let valueId = targetButton.dataset.valueId;
    
      filterValues[filterName] = valueId;

      filterTitle.innerHTML = valueName;
      filterToggle.addEventListener('click', applyFilter);
      filterToggle.removeEventListener('click', toggleFilterItem);

      closeFilterItems();      
    } 
    
    else {
      let defaultTitle = filterTitle.dataset.defaultValue;
      filterTitle.innerHTML = defaultTitle;

      delete filterValues[filterName];

      filterToggle.removeEventListener('click', applyFilter);
      filterToggle.addEventListener('click', toggleFilterItem);
    }

    filterItem.classList.toggle('selected');
  }

  if (filterType == 'tag') {
    let targetButton = event.target.closest('.js-apply-filter');    
    let tagItems = filterItem.querySelectorAll('.js-apply-filter');
    let isActive = targetButton.classList.contains('active');

    let coords = getCoords(filterItem);
    let scrollTo = coords.top - 20;

    window.scrollTo({ top: scrollTo, behavior: 'smooth' });

    tagItems.forEach(el => {
      el.classList.remove('active');
    })

    if (!isSelected) {
      targetButton.classList.add('active');
      let valueId = targetButton.dataset.valueId;
      filterValues[filterName] = valueId;

      filterItem.classList.toggle('selected');
    }
    
    else {
      delete filterValues[filterName];

      if (!isActive) {
        targetButton.classList.add('active');
        let valueId = targetButton.dataset.valueId;
        filterValues[filterName] = valueId;
      } else {
        filterItem.classList.toggle('selected');
      }
    }
  }
  
  if (filterType == 'price') {
    let filterTitle = filterItem.querySelector('.js-filter-title');
    let filterToggle = filterItem.querySelector('.js-filter-toggle');

    let currentMin = filterItem.dataset.currentMin;
    let currentMax = filterItem.dataset.currentMax;
    let globalMin = filterItem.dataset.globalMin;
    let globalMax = filterItem.dataset.globalMax;

    if (!isSelected) {

      if (currentMin == globalMin && currentMax == globalMax) {
        closeFilterItems();      
        return false;
      }

      let minFilterText = '';
      let maxFilterText = '';
      
      if (currentMin != globalMin) {
        minFilterText = 'от ' + currentMin + ' р.   '
        filterValues['minPrice'] = currentMin;
      }

      if (currentMax != globalMax) {
        maxFilterText = 'до ' + currentMax + ' р.'
        filterValues['maxPrice'] = currentMax;
      }

      filterTitle.innerHTML = minFilterText + maxFilterText;

      filterToggle.addEventListener('click', applyFilter);
      filterToggle.removeEventListener('click', toggleFilterItem);

      closeFilterItems();      
    } 
    
    else {
      let defaultTitle = filterTitle.dataset.defaultValue;
      filterTitle.innerHTML = defaultTitle;

      delete filterValues['minPrice'];
      delete filterValues['maxPrice'];

      filterItem.dataset.currentMin = globalMin;
      filterItem.dataset.currentMax = globalMax;

      filterToggle.removeEventListener('click', applyFilter);
      filterToggle.addEventListener('click', toggleFilterItem);
    }

    filterItem.classList.toggle('selected');
  }

  // ==== FOR GET REQUEST ====
  // delete filterValues['noFilters'];
  // let paramsObj = filterValues;
  // let searchParams = new URLSearchParams(paramsObj);
  // let filtersActive = (Object.keys(filterValues).length > 0) ? true : false;
  // if (filtersActive) {
  //   var refresh = window.location.protocol + "//" + window.location.host + window.location.pathname + "?" + searchParams;    
  //   window.history.pushState({ path: refresh }, '', refresh);
  // } else {
  //   var refresh = window.location.protocol + "//" + window.location.host + window.location.pathname;    
  //   window.history.pushState({ path: refresh }, '', refresh);
  //   filterValues['noFilters'] = true;
  // }
  // ==== FOR GET REQUEST ====
  
  let catalogInsertElement = document.querySelector('.js-catalog-section .js-ajax-insert');
  let priceFilterElement = document.querySelector('[data-filter-name="price"]');
  let durationFilterElement = document.querySelector('[data-filter-name="duration"]');
  let shipsFilterElement = document.querySelector('[data-filter-name="ships"]');
  let intervalFilterElement = document.querySelector('[data-filter-name="interval"]');

  let durationInsertElement = durationFilterElement.querySelector('.js-ajax-insert');
  let shipsInsertElement = shipsFilterElement.querySelector('.js-ajax-insert');
  let intervalInsertElement = intervalFilterElement.querySelector('.js-ajax-insert');

  let minPriceInput = priceFilterElement.querySelector('.js-input-min');
  let maxPriceInput = priceFilterElement.querySelector('.js-input-max');
  let minRangeInput = priceFilterElement.querySelector('.js-range-min');
  let maxRangeInput = priceFilterElement.querySelector('.js-range-max');
  let priceProgressBar = priceFilterElement.querySelector('.js-price-progress');

  let catalogDataElement = document.querySelector('.js-catalog-section');
  let showMoreItemsBtn = document.querySelector('.js-show-more-catalog-items');
  let parentId = catalogDataElement.dataset.parentId;
  
  let ajaxData = filterValues;
  ajaxData['action'] = 'applyFilter';
  ajaxData['parentId'] = parentId;
  ajaxData['offset'] = null;
  
  axios({
    method: 'post',
    url: '/ajax/action.php',
    data: ajaxData,
    headers: {'Content-Type': 'application/x-www-form-urlencoded'},
    responseType: 'json'
  })
  .then(function (response) {
    
    let catalogHtml = decodeURIComponent(response.data.html.catalog);
    let durationHtml = decodeURIComponent(response.data.html.duration);
    let shipsHtml = decodeURIComponent(response.data.html.ships);
    let intervalHtml = decodeURIComponent(response.data.html.interval);
 
    catalogInsertElement.innerHTML = catalogHtml;
    durationInsertElement.innerHTML = durationHtml;
    shipsInsertElement.innerHTML = shipsHtml;
    intervalInsertElement.innerHTML = intervalHtml;

    if (response.data.filterData) {
      priceFilterElement.classList.remove('no-options');
    
      let filterData = JSON.parse(response.data.filterData);
      let minPrice = filterData.filter.minPrice;
      let maxPrice = filterData.filter.maxPrice;

      priceFilterElement.dataset.globalMin = minPrice;
      priceFilterElement.dataset.globalMax = maxPrice;
      priceFilterElement.dataset.currentMin = minPrice;
      priceFilterElement.dataset.currentMax = maxPrice;
      
      minRangeInput.setAttribute('min', minPrice);
      minRangeInput.setAttribute('max', maxPrice);
      maxRangeInput.setAttribute('min', minPrice);
      maxRangeInput.setAttribute('max', maxPrice);
      
      minPriceInput.value = minPrice;
      maxPriceInput.value = maxPrice;
      minRangeInput.value = minPrice;
      maxRangeInput.value = maxPrice;

      priceProgressBar.style.left = "0%";
      priceProgressBar.style.right = "0%";


      let currentCount = Number(filterData.count.limit) + Number(filterData.count.offset);
      let totalCount = Number(filterData.count.total);

      catalogDataElement.dataset.currentCount = currentCount;
      catalogDataElement.dataset.totalCount = totalCount;



      if (typeof showMoreButton !== 'undefined' && showMoreButton) {
        if ((totalCount - currentCount) > 0) {
          showMoreItemsBtn.classList.remove('js-hidden');
        } else {
          showMoreItemsBtn.classList.add('js-hidden');
        }
      }

    } else {
      priceFilterElement.classList.add('no-options');
      if (showMoreItemsBtn) {
        showMoreItemsBtn.classList.add('js-hidden');
      }
      catalogDataElement.dataset.currentCount = 0;
      catalogDataElement.dataset.totalCount = 0;
    }


    initNzMoskvaWidgets();
    initTeplohodWidgets();
    addOnClickListeners('.js-apply-filter', applyFilter);
  })
  .catch(function (error) {
    console.log(error);
  });

}

//ANCHOR - applyShipFilter

function applyShipFilter(event) {
  const step = 6;

  let searchInput = document.querySelector('.js-ship-search-input');
  let searchBlock = document.querySelector('.js-search-block');
  let catalogElement = document.querySelector('.js-ships-catalog');
  let currentCount = catalogElement.dataset.currentCount;
  let parentId = catalogElement.dataset.parentId;
  let showMoreButton = catalogElement.querySelector('.js-show-more-ships')
  let filterType;
  let button;

  if (event.type == 'click') {
    button = event.target.closest('.js-apply-ship-filter');
    filterType = button.dataset.filterType;
  } else if (event.type == 'change') {
    filterType = 'search';
  } else {
    filterType = 'cancelSearch';
  }
  
  if (!filterType) {
    return false;  
  }
 

  switch (filterType) {
    case 'tags': 
      if (button.classList.contains('active')) {
        shipFilterValues['tag'] = '';
        button.classList.remove('active');
      } else {
        let tagButtons = document.querySelectorAll('.js-apply-ship-filter[data-filter-type="tags"]'); 
        tagButtons.forEach(el => {
          el.classList.remove('active');
        })

        button.classList.add('active');
        shipFilterValues['tag'] = button.dataset.filterValue;

      }
      break;
  
    case 'sort':
      let sort = button.dataset.sort;

      if (sort != shipFilterValues.sort) {
        let sortButtons = document.querySelectorAll('.js-apply-ship-filter[data-filter-type="sort"]');
        sortButtons.forEach(el => {
          el.classList.remove('active');
        })  
        button.classList.add('active');
        shipFilterValues['sort'] = sort;
      } else {
        return false;
      }
      break;

    case 'search':
      let query = searchInput.value;
      shipFilterValues['search'] = query;

      if (!query) {
        searchBlock.classList.add('active');
        return false;
      }

      searchBlock.classList.add('active');

      break;

    case 'cancelSearch':
      if (!searchBlock.classList.contains('active')) {
        return false;
      }
      searchInput.value = '';
      shipFilterValues['search'] = '';
      searchBlock.classList.remove('active');


      break;

    default:
      break;
  }


  let ajaxData = shipFilterValues;
  ajaxData['action'] = 'applyShipFilter';
  ajaxData['parentId'] = parentId;
  ajaxData['step'] = step;

  let insertElement = catalogElement.querySelector('.js-ajax-insert');

  axios({
    method: 'post',
    url: '/ajax/action.php',
    data: ajaxData,
    headers: {'Content-Type': 'application/x-www-form-urlencoded'},
    responseType: 'json'
  })
  .then(function (response) {
      let catalogHtml = decodeURIComponent(response.data.html);

      insertElement.innerHTML = catalogHtml;

      let totalCount = Number(response.data.totalCount);
      
      catalogElement.dataset.totalCount = totalCount;
      
      if (totalCount <= step) {
        catalogElement.dataset.currentCount = totalCount;
        showMoreButton.classList.add('js-hidden');
      } else {
        catalogElement.dataset.currentCount = step;
        showMoreButton.classList.remove('js-hidden');
      }

    })
    .catch(function (error) {
      console.log(error);
    });

}



//ANCHOR - showMoreArticles

function showMoreArticles(event) {

  const step = 6;

  let button = event.target;
  let groupElement = button.closest('.js-article-group');
  let totalCount = groupElement.dataset.totalCount;
  let currentCount = groupElement.dataset.currentCount;
  let groupId = groupElement.dataset.groupId;

  let loadingElement = groupElement.querySelector('.js-loading-items');
  let remainingCount = totalCount - currentCount;

  if (remainingCount <= 0) {
    event.target.classList.add('js-hidden');
    
    return false;  
  }

  event.target.classList.add('js-hidden');
  loadingElement.classList.remove('js-hidden');

  let ajaxData = filterValues;
  ajaxData['action'] = 'showMoreArticles';
  ajaxData['offset'] = currentCount;
  ajaxData['groupId'] = groupId;
  ajaxData['step'] = step;

  let insertElement = groupElement.querySelector('.js-ajax-insert');

  axios({
    method: 'post',
    url: '/ajax/action.php',
    data: ajaxData,
    headers: {'Content-Type': 'application/x-www-form-urlencoded'},
    responseType: 'json'
  })
  .then(function (response) {
      console.log('ajR=', response.data);
      let catalogHtml = decodeURIComponent(response.data.html);

      let htmlObj = document.createElement('div');
      htmlObj.innerHTML = catalogHtml;
      
      Array.from(htmlObj.children).forEach(el => {
        insertElement.append(el);
      })
        
      loadingElement.classList.add('js-hidden');
        
      if (remainingCount <= step) {
        groupElement.dataset.currentCount = Number(currentCount) + Number(remainingCount);
      } else {
        groupElement.dataset.currentCount = Number(currentCount) + Number(step);
        event.target.classList.remove('js-hidden');
      }

    })
    .catch(function (error) {
      console.log(error);
    });

}

//ANCHOR - showMoreCatalogItems

function showMoreCatalogItems(event) {
  let catalogDataElement = document.querySelector('.js-catalog-section');
  let currentCount = catalogDataElement.dataset.currentCount;
  let totalCount = catalogDataElement.dataset.totalCount;
  let loadingElement = document.querySelector('.js-loading-items');
  let parentId = catalogDataElement.dataset.parentId;

  console.log(catalogDataElement, currentCount);
  
  if ((totalCount - currentCount) <= 0) {
    event.target.classList.add('js-hidden');
    
    return false;  
  }

  event.target.classList.add('js-hidden');
  loadingElement.classList.remove('js-hidden');

  let textTagId = catalogDataElement.dataset.textTagId;
  if (textTagId) {
    filterValues['textTag'] = textTagId;
  }

  let pierId = catalogDataElement.dataset.pierId;
  if (pierId) {
    filterValues['pier'] = pierId;
  }

  let ajaxData = filterValues;
  ajaxData['action'] = 'applyFilter';
  ajaxData['offset'] = currentCount;
  ajaxData['parentId'] = parentId;

  let catalogInsertElement = document.querySelector('.js-catalog-section .js-ajax-insert');

  axios({
    method: 'post',
    url: '/ajax/action.php',
    data: ajaxData,
    headers: {'Content-Type': 'application/x-www-form-urlencoded'},
    responseType: 'json'
  })
  .then(function (response) {
      console.log('ajR=', response.data);
      let catalogHtml = decodeURIComponent(response.data.html.catalog);
      let filterData = JSON.parse(response.data.filterData);

      let currentCount = Number(filterData.count.limit) + Number(filterData.count.offset);
      let totalCount = Number(filterData.count.total);
      
      catalogDataElement.dataset.currentCount = currentCount;
      catalogDataElement.dataset.totalCount = totalCount;

      let htmlObj = document.createElement('div');
      htmlObj.innerHTML = catalogHtml;

      Array.from(htmlObj.children).forEach(el => {
        catalogInsertElement.append(el);
      })

      loadingElement.classList.add('js-hidden');
  
      if ((totalCount - currentCount) > 0) {
        event.target.classList.remove('js-hidden');
      }

      initTeplohodWidgets();
      initRadarioWidgets();
      initNzMoskvaWidgets();
    })
    .catch(function (error) {
      console.log(error);
    });

}


//ANCHOR - showMoreReviews

function showMoreReviews(event) {
  const step = 3;

  let insertElement = document.querySelector('.js-ajax-insert--reviews-messages');
  let detailedRatingElement = document.querySelector('.js-detailed-rating');
  let reviewsElements = document.querySelectorAll('.js-review-item');
  let triggerButton = event.target;
  let resourceId = document.querySelector('.js-page-data').dataset.id;

  let currentQuantity = reviewsElements.length;
  let maxQuantity = detailedRatingElement.dataset.reviewsCount;
  
  if (currentQuantity >= maxQuantity) {
    triggerButton.classList.add('js-hidden');
  
    return false;
  }

  let newQuantity = currentQuantity + step;
  newQuantity = (newQuantity >= maxQuantity) ? maxQuantity : newQuantity;

  let disableButton = (newQuantity == maxQuantity) ? true : false;

  let ajaxData = {
    action: 'showMoreReviews',
    resourceId,
    newQuantity
  }

  axios({
    method: 'post',
    url: '/ajax/action.php',
    data: ajaxData,
    headers: {'Content-Type': 'application/x-www-form-urlencoded'},
    responseType: 'json'
  })
    .then(function (response) {
      insertElement.innerHTML = response.data.html;
      initReviewsMessageImagesSwiper();
      defaultLightbox.reload();

      if (disableButton) {
        triggerButton.classList.add('js-hidden');
      }
    })
    .catch(function (error) {
      console.log(error);
    });
}

//ANCHOR - showMorePiers

function showMorePiers(event) {
  const step = 6;

  let button = event.target;
  let dataElement = button.closest('.js-piers-catalog');
  let totalCount = dataElement.dataset.totalCount;
  let currentCount = dataElement.dataset.currentCount;
  let parentId = dataElement.dataset.parentId;

  let loadingElement = dataElement.querySelector('.js-loading-items');
  let remainingCount = totalCount - currentCount;

  if (remainingCount <= 0) {
    event.target.classList.add('js-hidden');
    
    return false;  
  }

  event.target.classList.add('js-hidden');
  loadingElement.classList.remove('js-hidden');

  let ajaxData = filterValues;
  ajaxData['action'] = 'showMorePiers';
  ajaxData['offset'] = currentCount;
  ajaxData['step'] = step;
  ajaxData['parentId'] = parentId;

  let insertElement = dataElement.querySelector('.js-ajax-insert');

  axios({
    method: 'post',
    url: '/ajax/action.php',
    data: ajaxData,
    headers: {'Content-Type': 'application/x-www-form-urlencoded'},
    responseType: 'json'
  })
  .then(function (response) {
      console.log('ajR=', response.data);
      let catalogHtml = decodeURIComponent(response.data.html);

      let htmlObj = document.createElement('div');
      htmlObj.innerHTML = catalogHtml;
      
      Array.from(htmlObj.children).forEach(el => {
        insertElement.append(el);
      })
        
      loadingElement.classList.add('js-hidden');
        
      if (remainingCount <= step) {
        dataElement.dataset.currentCount = Number(currentCount) + Number(remainingCount);
      } else {
        dataElement.dataset.currentCount = Number(currentCount) + Number(step);
        event.target.classList.remove('js-hidden');
      }

    })
    .catch(function (error) {
      console.log(error);
    });
}

//ANCHOR - showMoreShips

function showMoreShips(event) {
  const step = 6;

  let button = event.target;
  let catalogElement = button.closest('.js-ships-catalog');
  let totalCount = catalogElement.dataset.totalCount;
  let currentCount = catalogElement.dataset.currentCount;
  let parentId = catalogElement.dataset.parentId;

  let loadingElement = catalogElement.querySelector('.js-loading-items');
  let remainingCount = totalCount - currentCount;

  if (remainingCount <= 0) {
    event.target.classList.add('js-hidden');
    
    return false;  
  }

  event.target.classList.add('js-hidden');
  loadingElement.classList.remove('js-hidden');

  let ajaxData = shipFilterValues;
  ajaxData['action'] = 'showMoreShips';
  ajaxData['offset'] = currentCount;
  ajaxData['parentId'] = parentId;
  ajaxData['step'] = step;

  let insertElement = catalogElement.querySelector('.js-ajax-insert');

  console.log('ajD', ajaxData);
  axios({
    method: 'post',
    url: '/ajax/action.php',
    data: ajaxData,
    headers: {'Content-Type': 'application/x-www-form-urlencoded'},
    responseType: 'json'
  })
  .then(function (response) {
      console.log('ajR=', response.data);
      let catalogHtml = decodeURIComponent(response.data.html);

      let htmlObj = document.createElement('div');
      htmlObj.innerHTML = catalogHtml;
      
      Array.from(htmlObj.children).forEach(el => {
        insertElement.append(el);
      })
        
      loadingElement.classList.add('js-hidden');

      if (remainingCount <= step) {
        catalogElement.dataset.currentCount = Number(currentCount) + Number(remainingCount);
      } else {
        catalogElement.dataset.currentCount = Number(currentCount) + Number(step);
        event.target.classList.remove('js-hidden');
      }

    })
    .catch(function (error) {
      console.log(error);
    });

}


//ANCHOR - selectCity 

function selectCity(city) {
  console.log(city);
  
  let cityEls = document.querySelectorAll('.js-city');

  for (const el of cityEls) {
    // el.innerText = city;
  }

  let = redirectUrl = '';
  let cookie = false;

  switch (city) {
    case 'Москва':
      cookie = 'msk';
      redirectUrl = '/';
      break;
  
    case 'Санкт-Петербург':
      cookie = 'spb';
      redirectUrl = '/rechnyie-progulki-spb/';
      break;

    case 'Казань':
      cookie = 'kzn';
      redirectUrl = '/rechnyie-progulki-kazan-katalog/';
      break;

    case 'Самара':
      cookie = 'sam';
      redirectUrl = '/rechnyie-progulki-samara-katalog/';
      break;

    case 'Чебоксары':
      cookie = 'chb';
      redirectUrl = '/rechnyie-progulki-cheboksari-katalog/';
      break;
  }

  document.cookie = "city=" + cookie + "; max-age=3000000; secure; path=/; samesite=strict";

  // window.location.replace(redirectUrl);
  window.location.replace('/');
}

//ANCHOR - toggleAgreement

function toggleAgreement(event) {
  let section = event.target.closest('.js-form-agreement-section');
  section.classList.toggle('checked');
  section.classList.remove('error');
}

//ANCHOR - closeCitySelector

function closeCitySelector(event) {
  let isSelectorEvent = event.target.closest('.js-header-city-selector');
  
  if (isSelectorEvent) {
    return false;
  }

  let selectorEl = document.querySelector('.js-header-city-selector');
  selectorEl.classList.remove('opened');
}


//ANCHOR - toggleCitySelector

function toggleCitySelector(event) {
  let selectorEl = event.target.closest('.js-header-city-selector');
  let isOpened = selectorEl.classList.contains('opened');
  let body = document.querySelector('body');
  
  if (isOpened) {
    body.removeEventListener('click', closeCitySelector);
    selectorEl.classList.remove('opened');
  } else {
    body.addEventListener('click', closeCitySelector);
    selectorEl.classList.add('opened');  
  }

  let isCityItem = event.target.classList.contains('js-select-city');

  if (isCityItem) {
    selectCity(event.target.innerText);
  }
}

//ANCHOR - scrollToElement
function scrollToElement(element, offset = 0) {
  let rect = element.getBoundingClientRect();
  let scrollCoord = rect.top + window.scrollY - offset;
  
  window.scrollTo(0, scrollCoord);
}


//ANCHOR - sendForm

// function sendForm(event) {
//   event.preventDefault();

//   let form = event.target.closest('form');
//   let formType = form.dataset.formType;
//   let insertElement = form.querySelector('.js-ajax-insert');

//   let hasErrors = validateForm(form);

//    if (hasErrors) {
//      let errorElement = form.querySelector('.error');
//      if (errorElement) {
//       // errorElement.scrollIntoView();
//       scrollToElement(errorElement, 70);

//       return false;
//      }

//      let errorFocusElement = document.querySelector('input.error-focus');
//      if (errorFocusElement) {
//       errorFocusElement.focus();

//       return false;
//      }
//    }

//   let targetButton = event.target;

//   targetButton.removeEventListener( "click" , sendForm);
  
//   if (targetButton.nodeName == 'IMG') {
//     targetButton.setAttribute('src', '/assets/img/icons/circle-dots.gif');
//     targetButton.style.filter = 'none';
//     targetButton.style.top = '34px';

//   } else {
//     targetButton.innerHTML = 'Работаем...'
//   }

//   let shipNameElement = document.querySelector('.js-resource-name');
//   let commentElement = document.querySelector('.js-comment-input');
//   let questionElement = document.querySelector('.js-question-input');

//   let shipName = shipNameElement ? shipNameElement.innerHTML : '';
//   let comment = commentElement ? commentElement.value : '';
//   let question = questionElement ? questionElement.value : '';

//   let ajaxData = {
//     action: 'sendForm',
//     shipName,
//     comment,
//     question,
//     formType
//   }

//   grecaptcha.ready(function() {
//     grecaptcha.execute('6Lc9_jgpAAAAAC_DfBvv9TK6T4EUDbY5-ia3g0kU', {action: 'submit'}).then(function(token) {
//       ajaxData['token'] = token; 

//       Array.from(form.elements).forEach(el => {
//         if (el.tagName != 'INPUT') {
//           return false;
//         }
//         ajaxData[el.name] = el.value;
//       })
    

//       axios({
//         method: 'post',
//         url: '/ajax/action.php',
//         data: ajaxData,
//         headers: {'Content-Type': 'application/x-www-form-urlencoded'},
//         responseType: 'json'
//       })
//       .then(function (response) {
                
//         if (!response.data.verificationStatus) {
//           window.location = verificationErrorUrl;

//           return false;
//         }

//         insertElement.innerHTML = response.data.html;


//         ym(metrikaId,'reachGoal','form_submit_all');

        

//         switch (formType) {
//           case 'gifts':
//             ym(metrikaId,'reachGoal','form_submit_gifts');

//           break;
        
//           case 'subscribe':
//             ym(metrikaId,'reachGoal','form_submit_subscribe');

//           break;

//           case 'header-request':
//             ym(metrikaId,'reachGoal','form_submit_main');

//           break;

//           case 'question':
//             ym(metrikaId,'reachGoal','form_submit_main');

//           break;
            
//           case 'ship-request':
//             ym(metrikaId,'reachGoal','form_submit_ship');

//           break;
//         }

//         console.log('form sent');
//       })
//       .catch(function (error) {
//         insertElement.innerHTML = formErrorMessage;
//         console.log(error);
//       });



//     });
//   });
// }




//!SECTION


//ANCHOR - INIT MODAL GALLERY

let modalSwipers = {};

function initModalGallery(event) {
  let dataElement = event.target.closest('[data-gallery-id]');
  console.log('initm', dataElement);
  if (!dataElement) {
    return false;
  }
  
  let galleryId = dataElement.dataset.galleryId;
  
  if (modalSwipers[galleryId]) {
    return false;
  }

  modalSwipers[galleryId] = new Swiper('.js-modal-gallery-swiper[data-gallery-id="' + galleryId + '"]', {
    // on: {
    //   init: function () {
    //     if (this.isLocked)
    //     {

    //     };
    //   },
    // },
    loop: true,
    // lazyPreloadPrevNext: 1,
  
    spaceBetween: 50,
    navigation: {
      nextEl: '[data-gallery-id="' + galleryId + '"] .js-slider-button-next',
      prevEl: '[data-gallery-id="' + galleryId + '"] .js-slider-button-prev',
    },
  });

}


//ANCHOR - INIT RADARIO WIDGET 

function initRadarioWidget(id) {
  if (!radario) {
    return false;
  }

  let elementId = 'radario' + id;

  let options = {
    buttonText: 'Купить билеты',
    createButton: true,
    standalone: false,
    key: id,
    appendId: elementId, 
    params: {
      eventType: "schedule",
      textBtnColor: "#FFFFFF",
      accentColor: "rgba(35, 119, 163, 1)"
    }
  }

  radario.Widgets.Afisha(options);
}

//ANCHOR - INIT NZ MOSKVA WIDGETS

function initNzMoskvaWidgets() {
  let nzMoskvaElements = document.querySelectorAll('.js-nz-moskva-widget');
  if (!nzMoskvaElements) {
    return false;
  }
  
  for (const element of nzMoskvaElements) {
    let id = element.dataset.id;

    let isLoaded = Boolean(element.querySelector('a'));

    if (isLoaded) {
      continue;
    }
    
    let buttonsContainer = element.parentElement;
    let script = buttonsContainer.querySelector('.js-nz-moskva-script');
    let scriptUrl = script.getAttribute('src');

    $.getScript(scriptUrl);

    let selector = ".p_widget_1_" + id;
    let varName = "data" + id;
  }
}

//ANCHOR - INIT RADARIO WIDGETS 

function initRadarioWidgets() {
  let radarioElements = document.querySelectorAll('[radario-button]');
  
  for (const element of radarioElements) {
    let widgetInited = element.querySelector('a');

    if (widgetInited) { 
      continue;
    }

    let id = element.dataset.radarioId;

    initRadarioWidget(id);
  }
}


//ANCHOR - SIMPLEBAR

Array.prototype.forEach.call(
  document.querySelectorAll('.js-filter-values'),
  (el) => new SimpleBar(el, {
    autoHide: false
  })
);


//ANCHOR - GLIGHTBOX 

const mainGalleryLightbox = GLightbox({
  selector: '.glightbox-main-gallery',
  touchNavigation: true,
  loop: true,
  description: ' / '
});

mainGalleryLightbox.on('open', () => {
  setGlightboxSlidesCount();
})

mainGalleryLightbox.on('slide_changed', ({prev, current}) => {
  setGlightboxSlidesCount(current);
})

const defaultLightbox = GLightbox({
  selector: '.glightbox',
  touchNavigation: true,
  loop: true,
})


function setGlightboxSlidesCount(currentObj = false) {
  let currentSlideElement = document.querySelector('.swiper-pagination-current');
  let totalSlidesElement = document.querySelector('.swiper-pagination-total');
  let descriptionElements = document.querySelectorAll('.gslide-desc');

  if (!currentSlideElement || !totalSlidesElement || !descriptionElements) {
    return false;
  }

  current = currentObj ? currentObj.index + 1 : currentSlideElement.innerText;
  let total = totalSlidesElement.innerText;

  for (const element of descriptionElements) {
    element.innerText = current + ' / ' + total;
  }
}

let windowHeight = document.documentElement.clientHeight;
let goToTopBtn = document.querySelector(".js-go-to-top-btn");
if (goToTopBtn) {
    window.addEventListener("scroll", scrollToTopBtnCheck)

    goToTopBtn.addEventListener( "click" , () => {
        window.scrollTo({ top: 0, behavior: 'smooth' });
    })
}

function scrollToTopBtnCheck() {
      const heightOffset = 400;
      let scrollHeight = window.pageYOffset;
      if (scrollHeight > (windowHeight + heightOffset)) {
          goToTopBtn.classList.remove('js-hidden');
      } else {
          goToTopBtn.classList.add('js-hidden');
      }
}


function setCookie(name, value, days) {
    let expires = "";
    if (days) {
        let date = new Date();
        date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
        expires = "; expires=" + date.toUTCString();
    }
    document.cookie = name + "=" + (value || "") + expires + "; path=/";
}

function getCookie(name) {
    let matches = document.cookie.match(new RegExp("(?:^|; )" + name.replace(/([\.$?*|{}\(\)\[\]\\\/\+^])/g, '\\$1') + "=([^;]*)"));
    return matches ? decodeURIComponent(matches[1]) : undefined;
}


function checkCookies() {
    let cookieNote = document.getElementById('cookie_note');
    let cookieBtnAccept = cookieNote.querySelector('.cookie_accept');

    // Если куки cookies_policy нет или она просрочена, то показываем уведомление
    if (!getCookie('cookies_policy')) {
        cookieNote.classList.remove('js-hidden');
    }

    // При клике на кнопку устанавливаем куку cookies_policy на один год
    cookieBtnAccept.addEventListener('click', function () {
        setCookie('cookies_policy', 'true', 365);
        cookieNote.classList.add('js-hidden');
    });
}

scrollToTopBtnCheck();