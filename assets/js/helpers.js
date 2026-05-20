function selectElement(targetEl, selector, className = 'active') {
    let selectedEl = targetEl.closest(selector);
    let allEls = document.querySelectorAll(selector);

    for (const el of allEls) {
        el.classList.remove(className);
    }

    selectedEl.classList.add(className);
}

function uppercaseFirst(str) {
    let firstLetter = str.charAt(0)
    let firstLetterCap = firstLetter.toUpperCase()
    let remainingLetters = str.slice(1)
    let result = firstLetterCap + remainingLetters

    return result;
}

function isObjEmpty(obj) {
  for (const prop in obj) {
    if (Object.hasOwn(obj, prop)) {
      return false;
    }
  }

  return true;
}

function logJsErrors(error, data = {}) {
    const stack = new Error().stack;
    const callerName = logJsErrors.caller.name;

    let ajaxData = {
        action: 'logJsErrors',
        site: window.location.hostname,
        url: window.location,
        error,
        data
    };

    console.log('errorDataJS: ', ajaxData);
    
    axios({
		method: "post",
		url: "/ajax/action.php",
		data: ajaxData,
		headers: { "Content-Type": "application/x-www-form-urlencoded" },
		responseType: "json",
	})
	.then(function (response) {
		console.log("error logged");
        console.log(response);
        
	})
	.catch(function (error) {
		console.log("logger error:", error);
	});

}

function scrollToElement(element, offset = 0) {
  let rect = element.getBoundingClientRect();
  let scrollCoord = rect.top + window.scrollY - offset;
  
  window.scrollTo(0, scrollCoord);
}

function clearNumber(string, needStringOutput = false) {
   let clearString = string.replace(/\D/g, '');
 
   if (!needStringOutput) {
     number = Number(clearString);
   } else {
     number = clearString;
   }
 
   return number;
}

function deleteCookie(name) {
   setCookie(name, "", {
     'max-age': -1
   })
}

function formatNumber(value) {
   return value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ' ');
}

function getCookie(name) {
  let matches = document.cookie.match(new RegExp(
    "(?:^|; )" + name.replace(/([\.$?*|{}\(\)\[\]\\\/\+^])/g, '\\$1') + "=([^;]*)"
  ));
  return matches ? decodeURIComponent(matches[1]) : undefined;
}

function setCookie(name, value, options = {}) {
   options = {
     path: '/',
   };
 
   if (options.expires instanceof Date) {
     options.expires = options.expires.toUTCString();
   }
 
   let updatedCookie = encodeURIComponent(name) + "=" + encodeURIComponent(value);
 
   for (let optionKey in options) {
     updatedCookie += "; " + optionKey;
     let optionValue = options[optionKey];
     if (optionValue !== true) {
       updatedCookie += "=" + optionValue;
     }
   }
 
   document.cookie = updatedCookie;
}

function addOnClickListener(selector, func) {
    let element = document.querySelector(selector);
    if (element) {
        element.addEventListener('click', func);
    }
}

function addOnClickListeners(selector, func) {
    let elements = document.querySelectorAll(selector);
    if (elements) {
        for (var i = 0; i < elements.length; i++) {
            elements[i].addEventListener("click", func);
        }
    }
}

function removeOnClickListeners(selector, func) {
    let elements = document.querySelectorAll(selector);
    if (elements) {
        for (var i = 0; i < elements.length; i++) {
            elements[i].removeEventListener("click", func);
        }
    }
}

function addOnMouseEnterListeners(selector, func) {
    let elements = document.querySelectorAll(selector);
    if (elements) {
       for (var i = 0; i < elements.length; i++) {
          elements[i].addEventListener("mouseenter", func);
       }
    }
}

function addOnMouseLeaveListeners(selector, func) {
    let elements = document.querySelectorAll(selector);
    if (elements) {
       for (var i = 0; i < elements.length; i++) {
          elements[i].addEventListener("mouseleave", func);
       }
    }
}

function addOnMouseOverListeners(selector, func) {
    let elements = document.querySelectorAll(selector);
    if (elements) {
       for (var i = 0; i < elements.length; i++) {
          elements[i].addEventListener("mouseover", func);
       }
    }
}

function addOnScrollListeners(selector, func) {
    let elements = document.querySelectorAll(selector);
    if (elements) {
       for (var i = 0; i < elements.length; i++) {
          elements[i].addEventListener("scroll", func);
       }
    }
}

function addOnFocusListeners(selector, func) {
   let elements = document.querySelectorAll(selector);
   if (elements) {
      for (var i = 0; i < elements.length; i++) {
         elements[i].addEventListener("focus", func);
      }
   }
}

function addOnFocusOutListeners(selector, func) {
   let elements = document.querySelectorAll(selector);
   if (elements) {
      for (var i = 0; i < elements.length; i++) {
         elements[i].addEventListener("focusout", func);
      }
   }
}

function addOnInputListeners(selector, func) {
   let elements = document.querySelectorAll(selector);
   if (elements) {
      for (var i = 0; i < elements.length; i++) {
         elements[i].addEventListener("input", func);
      }
   }
}

function addOnChangeListeners(selector, func) {
   let elements = document.querySelectorAll(selector);
   if (elements) {
      for (var i = 0; i < elements.length; i++) {
         elements[i].addEventListener("change", func);
      }
   }
}