const inputErrors = {
	nameEmpty: "Необходимо ввести имя",
	phoneEmpty: "Необходимо ввести телефон",
	phoneShort: "Введите телефон полностью",
	emailEmpty: "Необходимо ввести email",
	emailWrong: "Введен некорректный email",
	innShort: "Введите ИНН полностью",
	snilsShort: "Введите СНИЛС полностью",
	default: "Необходимо заполнить поле",
};

const yaCaptchaSiteKey = "ysc1_ElfGc3nsoPbqp6B5y6Pdee9tjkZiKcdsh1NvZ7uY56a55983";
const metrikaId = "88955648";

const formErrorMessage = `
    К сожалению, при отправке произошла ошибка.
    Обновите страницу и попробуйте еще раз или свяжитесь с нами по телефону или электронной почте.
    Приносим извинения за неудобства.
`;

let lockFormEvent = false;

let orderProducts = [];
let orderNumber = false;
let orderCreateTries = 0;

document.addEventListener("DOMContentLoaded", bindFormEvents);
document.addEventListener("DOMContentLoaded", setInputMasks);

if (window.location.pathname == '/anketa-sb') {
	document.addEventListener("DOMContentLoaded", setInputValuesFromStorage);
}

function bindFormEvents() {
	addOnClickListeners(".js-send-form", sendFormWithErrorHandling);
	addOnClickListeners(".js-select-input-list", selectInputList);
	addOnClickListeners(".js-open-input-list", toggleInputList);
	addOnClickListeners(".js-radio-item", selectRadioInput);
	addOnClickListeners(".js-agreement-btn", toggleAgreement);
    addOnClickListeners('.js-form-add-section', addFormSection);
    addOnClickListeners('.js-disable-inputs', disableInputs);
    addOnClickListeners('.js-toggle-inputs', toggleInputs);

	addOnFocusListeners(".js-input-field", toggleInputFocus);
	addOnFocusOutListeners(".js-input-field", toggleInputFocus);

	if (window.location.pathname == '/anketa-sb') {
		addOnChangeListeners('input', saveInputValueToStorage);
	} 

	let hasInputLists = document.querySelector(".js-open-input-list");
	if (hasInputLists) {
		addOnClickListeners("body", closeInputLists);
	}

	function addOnClickListeners(selector, func) {
		let elements = document.querySelectorAll(selector);
		if (elements) {
			for (var i = 0; i < elements.length; i++) {
				elements[i].addEventListener("click", func);
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

	function addOnChangeListeners(selector, func) {
		let elements = document.querySelectorAll(selector);
		if (elements) {
			for (var i = 0; i < elements.length; i++) {
				elements[i].addEventListener("change", func);
			}
		}
	}
}

function getClientIdByYandex() {
	let uclid;
	ym(metrikaId, "getClientID", function (clientID) {
		uclid = clientID;
	});

	return uclid;
}

// --- YACAPTCHA SECTION ---


let captchaWidgetId = false;
let formEvent = false;

function initCaptcha() {
	if (window.smartCaptcha) {
		let container = document.createElement("div");
		document.body.append(container);

		captchaWidgetId = window.smartCaptcha.render(container, {
			sitekey: yaCaptchaSiteKey,
			hl: "ru",
			test: false,
			invisible: true,
			hideShield: true,
		});

		const onSuccess = window.smartCaptcha.subscribe(
			captchaWidgetId,
			"success",
			() => {
				console.log("captcha token recieved");

				lockFormEvent = false;
				sendFormWithErrorHandling(formEvent);
			}
		);

		const onTokenExpired = window.smartCaptcha.subscribe(
			captchaWidgetId,
			"success",
			() => window.smartCaptcha.reset()
		);

		const onNetworkError = window.smartCaptcha.subscribe(
			captchaWidgetId,
			"network-error",
			() => {
				let message = `
					Сетевая ошибка YandexCaptcha. 
					Обновите страницу и попробуйте отправить форму повторно, либо свяжитесь с нами другим способом.
				`;
			}
		);

		console.log("captcha inited");
	}
}

function saveInputValueToStorage(event) {
	let input = event.target;
	let value = input.value;
	let name = input.name;

	if (!name) {
		return false;
	}

	let storageName = 'input_' + name;

	localStorage.setItem(storageName, value);
}


function clearInputsStorage() {
	if (window.location.pathname != '/anketa-sb') {
		return false;
	}

	let storageLength = localStorage.length;
	let keysToRemove = [];
	
	for (let i = 0; i < storageLength; i++) {
		let key = localStorage.key(i);
		let isInputKey = key.includes('input_');

		if (isInputKey) {
			keysToRemove.push(key);
		}
	}

	for (const key of keysToRemove) {
		localStorage.removeItem(key);
	}
}

function setInputValuesFromStorage() {
	for (let i = 0; i < localStorage.length; i++) {
		let key = localStorage.key(i);

		let isInputKey = key.includes('input_');

		if (!isInputKey) {
			continue;
		}

		let name = key.replace('input_', '');
		let value = localStorage.getItem(key);

		let inputs = document.querySelectorAll(`input[name=${name}]`);

		if (!inputs) {
			continue;
		}

		for (const input of inputs) {
			input.value = value;

			let formGroup = input.closest('.form-group');

			if (!formGroup || !value) {
				continue;
			}

			formGroup.classList.add('focused');
		}
	}
}

function getCaptchaToken() {
	if (!window.smartCaptcha) {
		logFormError("!window.smartCaptcha (no smartCaptcha instance)");

		return false;
	}

	let token = window.smartCaptcha.getResponse();

	if (!token) {
		window.smartCaptcha.execute();
		console.log("execute captcha");
	} else {
		return token;
	}
}

// --- end YACAPTCHA SECTION ---

function addFormSection(event) {
	event.preventDefault();
	let button = event.target;
	let formBlock = button.closest(".js-form-block");
	let formSections = formBlock.querySelectorAll(".js-vacancy-block-wrapper");
	let lastSectionId = Object.keys(formSections).length;
	let newSectionId = lastSectionId + 1;

	let lastSection;

	if (lastSectionId === 1) {
		lastSection = formBlock.querySelector(".js-vacancy-block-wrapper");
	} else {
		lastSection = formBlock.querySelector(
			'.js-vacancy-block-wrapper[data-id="' + lastSectionId + '"]'
		);
	}

	let newSection = lastSection.cloneNode(true);
	newSection.setAttribute("data-id", newSectionId);
	let inputFields = newSection.querySelectorAll(".js-input-field");

	for (const field of inputFields) {
		let name = field.name.replace(/[0-9]/g, "") + newSectionId;
		field.setAttribute("name", name);
		field.value = "";
	}

	lastSection.after(newSection);
	setInputMasks();
}

function disableInputs(event, forceSwitch = false) {
	let formBlock = event.target.closest(".js-form-block");
	let formGroup = event.target.closest(".js-form-group");
	let checkbox = event.target.closest(".js-input-checkbox");
	let disableInput = formGroup.querySelector(".js-disable-input");

	if (checkbox) {
		checkbox.classList.toggle("checked");
	}

	if (forceSwitch == "disable") {
		formBlock.classList.add("disabled");
	} else if (forceSwitch == "enable") {
		formBlock.classList.remove("disabled");
	} else {
		formBlock.classList.toggle("disabled");
	}

	let isDisabled = formBlock.classList.contains("disabled");

	if (disableInput) {
		disableInput.value = isDisabled ? "Да" : "Нет";
	}

	let formGroups = formBlock.querySelectorAll(".js-form-group");

	for (const group of formGroups) {
		if (group.classList.contains("js-disable-group")) {
			let input = group.querySelector(".js-input-wrapper input");

			if (!input) {
				continue;
			}

			if (isDisabled) {
				input.dataset.disabled = "no";
			} else {
				input.dataset.disabled = "yes";
			}

			let inputWrapper = group.querySelector(".js-input-wrapper");
			inputWrapper.classList.toggle("js-hidden");

			continue;
		}

		let addSectionButton = formBlock.querySelector(".js-form-add-section");

		if (isDisabled) {
			group.classList.add("js-hidden");

			let inputs = group.querySelectorAll("input");
			for (const input of inputs) {
				input.dataset.disabled = "yes";
			}

			if (addSectionButton) {
				addSectionButton.classList.add("js-hidden");
			}
		} else {
			group.classList.remove("js-hidden");

			let inputs = group.querySelectorAll("input");
			for (const input of inputs) {
				input.dataset.disabled = "no";
			}
			if (addSectionButton) {
				addSectionButton.classList.remove("js-hidden");
			}
		}
	}
}

function toggleAgreement(event) {
	let section = event.target.closest(".js-form-agreement-section");
	section.classList.toggle("checked");
	section.classList.remove("error");
}

function resetForm(form) {
	form.reset();
	let formGroups = form.querySelectorAll(".form-group");

	if (!formGroups) {
		return false;
	}

	for (const group of formGroups) {
		group.classList.remove("focused");
	}

	let errorLabels = form.querySelectorAll("label.error");

	for (const label of errorLabels) {
		label.innerHTML = "";
	}

	let listTitles = form.querySelectorAll(".js-title");

	for (const title of listTitles) {
		title.innerHTML = "";
	}
}

function getFormData(form) {
	let result = {};
	let formGroups = form.querySelectorAll(".js-form-group");

	for (const group of formGroups) {
		let inputs = group.querySelectorAll("input, textarea");

		for (const input of inputs) {
			if (group.classList.contains("js-disabled-input")) {
				continue;
			}

			if (input.dataset.disabled == "yes") {
				continue;
			}

			if (input.type == "file") {
				continue;
			}

			if (input.type == "radio" && !input.checked) {
				continue;
			}

			let label = group.querySelector(".input-label");
			let title = label ? label.textContent : input.name;
			title = title.replace("*", "");
			title = title.trim();

			let name = input.name;
			let value = input.value;

			let field = {
				name,
				title,
				value,
			};

			result[name] = field;
		}
	}

	console.log('result=', result);
	return result;
}

function logFormError(error, event = false) {
	event = event || formEvent;
	data = {};

	if (event) {
		let form = event.target.closest("form");

		data["formType"] = form.dataset.formType;
		data["inputFields"] = getFormData(form);
	}

	logJsErrors(error, data);
}

function sendFormWithErrorHandling(event) {
	try {
		sendForm(event);
	} catch (error) {
		let message = { 
            title: "sendForm() js error",
            message: error.message,
            stack: error.stack
        };
		logFormError(message, event);
	}
}

function sendForm(event) {
	event.preventDefault();

	console.log('sendStart');
	
	if (lockFormEvent) {
		return false;
	}

	if (!window.smartCaptcha) {
		let message = `
			Ошибка иницилизации YandexCaptcha. 
			Обновите страницу и попробуйте отправить форму повторно, либо свяжитесь с нами другим способом.
		`;

		logFormError(message, event);
		alert(message);

		return false;
	}

	let form = event.target.closest("form");
	let formType = form.dataset.formType;
	let successType = form.dataset.successType || "modal";
	let insertElement = form.querySelector(".js-ajax-insert");

	let hasErrors = validateForm(form);

	// DEBUG ONLY
	// hasErrors = false;

	if (hasErrors) {
		handleInputErrors();

		return false;
	}

	let targetButton = event.target;
	lockFormEvent = true;
	const processBtnText = 'Работаем...';

	if (targetButton.innerHTML != processBtnText) {
		buttonText = targetButton.innerHTML;
	}

	if (targetButton.nodeName == "IMG") {
		targetButton.setAttribute("src", "/assets/img/icons/circle-dots.gif");
		targetButton.style.filter = "none";
		targetButton.style.top = "34px";
	} else {
		targetButton.innerHTML = processBtnText;
	}

	let token = getCaptchaToken();
	if (!token) {
		formEvent = event;

		return false;
	} else {
		window.smartCaptcha.reset();
	}

	let commentElement = document.querySelector(".js-comment-input");
	let comment = commentElement ? commentElement.value : "";

	let resourceIdElement = document.querySelector(".js-resource-id");
	let resourceId = resourceIdElement ? resourceIdElement.innerText : "";

	let pageTypeElement = document.querySelector('meta[name="pagetype"]');
	let pageType = pageTypeElement
		? pageTypeElement.getAttribute("content")
		: "private";

	let url = window.location.href;
	let pagetitle = form.elements["pagetitle"] ? form.elements["pagetitle"].innerText : false;

	if (!pagetitle) {
		let h1 = document.querySelector("h1");

		if (h1) {
			pagetitle = h1.innerText;
		}
	}

	if (!pagetitle) {
		pagetitle = url;
	}

	let formtitle = form.elements["formtitle"] ? form.elements["formtitle"].innerText : '';

    let ajaxData = {
        action: "sendForm",
        formtitle,
        pagetitle,
        url,
        comment,
        resourceId,
        formType,
        pageType,
        token,
        visiterSource: sessionStorage.getItem("visiter_source"),
    };

    let isCreateOrder = targetButton.classList.contains('js-create-order'); 

	console.log('order=', orderNumber);
	

    if (isCreateOrder) {
      if (!orderNumber) {
        createOrder(event);
        return false;
      }

      ajaxData['orderNumber'] = orderNumber;
      ajaxData['orderProducts'] = orderProducts;
      ajaxData['orderSum'] = basket.totalSum;
    } 

	if (formType == "basket" && typeof basket !== 'undefined') {
		ajaxData["orderProducts"] = basket.getStorage();
		ajaxData["orderSum"] = basket.getTotalSum();
	}

	ajaxData["inputFields"] = getFormData(form);
    
	let uploadInput = form.querySelector('input[name="upload"]');
	if (uploadInput) {
		ajaxData["uploadFolder"] = uploadInput.value;
	}


	console.log("submit");
	console.log("ajaxData", ajaxData);

	axios({
		method: "post",
		url: "/ajax/action.php",
		data: ajaxData,
		headers: { "Content-Type": "application/x-www-form-urlencoded" },
		responseType: "json",
	})
	.then(function (response) {
		console.log(response);
		
		if (response.data.captchaResult != "success") {
			let message = `
			Ошибка валидации токена YandexCaptcha. 
			Обновите страницу и попробуйте отправить форму повторно, либо свяжитесь с нами другим способом.
		`;

			alert(message);

			return false;
		}

		console.log(response);
		
		resetForm(form);

		// targetButton.addEventListener("click", sendForm);
		lockFormEvent = false;
		targetButton.innerHTML = buttonText;

		if (successType == "modal") {
			handleModalAfterSubmit(formType);
		} else {
			insertElement.innerHTML = response.data.html;
		}

		hideAfterSubmitEls(form);
		showAfterSubmitEls(form);
		clearInputsStorage(ajaxData);

		handleCustomAfterSubmit(form, formType, ajaxData);

		sendYmEvents(formType);

		console.log("form sent");
	})
	.catch(function (error) {
		let message = { 
            title: "ajax error",
            message: error.message,
            stack: error.stack
        };

		logFormError(message, event);

		alert(formErrorMessage);

		console.log(error);
	});
}


function handleInputErrors() {
	let formErrorElement = document.querySelector(".form-group.error");
	let agreementErrorElement = document.querySelector(
		".js-form-agreement-section.error"
	);

	let errorElement = formErrorElement || agreementErrorElement;

	let scrollShift = 70;

	console.log('error-elem: ', errorElement);
	
	if (errorElement) {
		let isModal = errorElement.closest(".hystmodal__window");

		if (!isModal) {
			scrollToElement(errorElement, scrollShift);
		} else {
			errorElement.scrollIntoView();
		}

		return false;
	}


	let errorFocusElement = document.querySelector("input.error-focus");

	console.log('error-focus-elem: ', errorFocusElement);

	if (errorFocusElement) {
		errorFocusElement.focus();
		scrollToElement(errorFocusElement, scrollShift);

		return false;
	}
}

function handleCustomAfterSubmit(form, formType, ajaxData) {
	if (formType == "order") {
		basket.clearBasket();
		window.location.replace("/order_success");

		return false;
	}
}

function handleModalAfterSubmit(formType) {
	if (!Hystmodal) {
		return false;
	}

	const autoclose = false;
	let hystmodalId = "#success-modal";

	switch (formType) {
		// case "cta-question-popup":
		// 	hystmodalId = "#success-modal-faq";
		// 	break;

		// case "cta-popup":
		// 	hystmodalId = "#success-modal-service";
		// 	break;

		// case "nalog":
		// 	hystmodalId = "#success-modal-nalog";
		// 	break;
	}

	Hystmodal.open(hystmodalId);

	if (autoclose) {
		setTimeout(() => {
			Hystmodal.close();
		}, 3000);
	}
}

function hideAfterSubmitEls(form) {
	let elementsToHide = form.querySelectorAll(".js-hide-after-submit");
	if (elementsToHide) {
		for (const element of elementsToHide) {
			element.classList.add("js-hidden");
		}
	}
}

function showAfterSubmitEls(form) {
	let elementsToShow = form.querySelectorAll(".js-show-after-submit");
	if (elementsToShow) {
		for (const element of elementsToShow) {
			element.classList.remove("js-hidden");
		}
	}
}

function sendYmEvents(formType) {
    if (typeof ym === "undefined") {
        return false;
	}

	let ymGoal = false;

	switch (formType) {
		case "mortgage":
			ymGoal = "forma-ipoteka";
			break;

		case "feedback-modal":
			ymGoal = "v-shapke";
			break;

		case "express":
			ymGoal = "ehkspress-zayavka";
			break;

		case "feedback":
			ymGoal = "ostalis-voprosy";
			break;

		case "feedback-banner-modal":
			ymGoal = "bannerblog";
			break;

		case "osago":
			ymGoal = "kalkulyatory-osago";
			break;

		case "kasko":
			ymGoal = "kalkulyator-kasko";
			break;
	}

	if (formType != "vacancy") {
		if (ymGoal) {
			ym(metrikaId, "reachGoal", ymGoal);
		}

		ym(metrikaId, "reachGoal", "vse-formy");
	}
}

function validateForm(form) {
	let hasErrors = false;

	Array.from(form.elements).forEach((el) => {
		if (!el.classList.contains("required")) {
			return false;
		}

		if (el.dataset.disabled == "yes") {
			return false;
		}

		let formGroup = el.closest(".js-form-group");
		let errorLabel = formGroup.querySelector(".error");
		let valid;
		let errorText;

		if (formGroup.classList.contains("js-disabled-input")) {
			return false;
		}

		let name = el.name;

		let isPhone = name.toLowerCase().includes("phone");
		if (isPhone) {
			name = "phone";
		}

		switch (name) {
			case "name":
				valid = v8n().not.empty().test(el.value);
				errorText = inputErrors.nameEmpty;
				break;

			case "phone":
				let phone = clearNumber(el.value, true);
				valid = v8n().not.empty().test(phone);
				errorText = inputErrors.phoneEmpty;

				if (valid) {
					valid = v8n().length(11).test(phone);
					errorText = inputErrors.phoneShort;
				}
				break;

			case "email":
				valid = v8n().not.empty().test(el.value);
				errorText = inputErrors.emailEmpty;

				if (valid) {
					valid = v8n()
						.pattern(/.+\@.+\..+/)
						.test(el.value);
					errorText = inputErrors.emailWrong;
				}
				break;

			case "companyINN":
				valid = v8n().not.empty().test(el.value);
				errorText = inputErrors.default;

				if (valid) {
					valid = v8n().length(10, 12).test(el.value);
					errorText = inputErrors.innShort;
				}
				break;

			case "INN":
				valid = v8n().not.empty().test(el.value);
				errorText = inputErrors.default;

				if (valid) {
					valid = v8n().length(12).test(el.value);
					errorText = inputErrors.innShort;
				}
				break;

			case "SNILS":
				valid = v8n().not.empty().test(el.value);
				errorText = inputErrors.default;

				if (valid) {
					valid = v8n().length(14).test(el.value);
					errorText = inputErrors.snilsShort;
				}
				break;

			default:
				valid = v8n().not.empty().test(el.value);
				errorText = inputErrors.default;
				break;
		}

		if (!valid) {
			hasErrors = true;
			formGroup.classList.add("error");
			errorLabel.innerHTML = errorText;
		} else {
			formGroup.classList.remove("error");
		}
	});

	Array.from(form.elements).forEach((el) => {
		if (el.tagName != "INPUT" || !el.classList.contains("required-focus")) {
			return false;
		}

		let name = el.name;

		let isPhone = name.toLowerCase().includes("phone");
		if (isPhone) {
			name = "phone";
		}

		switch (name) {
			case "name":
				valid = v8n().not.empty().test(el.value);
				break;

			case "phone":
				let phone = clearNumber(el.value, true);
				valid = v8n().not.empty().test(phone);

				if (valid) {
					valid = v8n().length(11).test(phone);
				}
				break;

			case "email":
				valid = v8n().not.empty().test(el.value);

				if (valid) {
					valid = v8n()
						.pattern(/.+\@.+\..+/)
						.test(el.value);
				}
				break;

			case "personal_agreement":
				valid = el.checked;
				break;

			default:
				valid = v8n().not.empty().test(el.value);
				break;
		}

		if (!valid) {
			hasErrors = true;
			el.classList.add("error-focus");
		} else {
			el.classList.remove("error-focus");
		}
	});

	let agreementSections = form.querySelectorAll(".js-form-agreement-section");

	for (const agreementSection of agreementSections) {
		if (agreementSection) {
			let isChecked = agreementSection.classList.contains("checked");
			if (!isChecked) {
				agreementSection.classList.add("error");
				hasErrors = true;
			} else {
				agreementSection.classList.remove("error");
			}
		}
	}

	let fileUploadSection = form.querySelector(".js-file-upload-section");

	if (fileUploadSection) {
		let hasFiles = Boolean(
			fileUploadSection.querySelector(".filepond--file")
		);

		if (!hasFiles) {
			fileUploadSection.classList.add("error");
			hasErrors = true;
		} else {
			fileUploadSection.classList.remove("error");
		}
	}

	return hasErrors;
}

function setInputMasks() {
    let phoneInputs = document.querySelectorAll('input[name*="phone"]');
    let priceInputs = document.querySelectorAll('.js-price-input');
    let debtInputs = document.querySelectorAll('input[name="outstandingDebt"]');
    let cargoCostInputs = document.querySelectorAll('input[name="cargoCost"]');
    let propertySumInputs = document.querySelectorAll('input[name="propertySum"]');
    let contractSumInputs = document.querySelectorAll('input[name="contractSum"]');
    let birthdayInputs = document.querySelectorAll('input[name="birthday"]');

    const { Mask, MaskInput, vMaska } = Maska;

    if (phoneInputs) {
        new MaskInput(phoneInputs, { mask: "+# (###) ###-##-##" })
    }

    if (priceInputs) {
        new MaskInput(priceInputs, { mask: "#######" })
    }

    if (debtInputs) {
        new MaskInput( debtInputs, { 
            mask: "### ### ### ### ###",
            reversed: true,
        })
    }

    if (cargoCostInputs) {
        new MaskInput( cargoCostInputs, { 
            mask: "### ### ### ### ###",
            reversed: true,
        })
    }

    if (propertySumInputs) {
        new MaskInput( propertySumInputs, { 
            mask: "### ### ### ### ###",
            reversed: true,
        })
    }

    if (contractSumInputs) {
        new MaskInput( contractSumInputs, { 
            mask: "### ### ### ### ###",
            reversed: true,
        })
    }

    if (birthdayInputs) {
        new MaskInput(birthdayInputs, { mask: "##.##.####" })
    }

    new MaskInput("[data-maska]");
}

function selectInputList(event) {
	let selectedValue = event.target.innerHTML;

	let formGroup = event.target.closest(".js-form-group");
	let input = formGroup.querySelector(".js-input");
	let title = formGroup.querySelector(".js-title");
	let values = formGroup.querySelectorAll(".js-select-input-list");


	input.value = selectedValue;
	title.innerHTML = selectedValue;

	for (const value of values) {
		value.classList.remove("selected");
	}

	event.target.classList.add("selected");

	//SA-PROGRESS
	if (input.name == "factAddressIsRegisterAddress") {
		toggleFactAddressFields(input);
	}
	//!SA-PROGRESS

	closeInputLists();

    //SA-PROGRESS
	if (formGroup.classList.contains("js-check-family")) {
		let formBlock = event.target.closest(".js-form-block");
		let formGroups = formBlock.querySelectorAll(".js-form-group");

		if (selectedValue == "женат" || selectedValue == "замужем") {
			for (const group of formGroups) {
				group.classList.add("required");
				let groupInput = group.querySelector("input");
				groupInput.classList.add("required");
			}
		} else {
			for (const group of formGroups) {
				group.classList.remove("required");
				let groupInput = group.querySelector("input");
				groupInput.classList.remove("required");
			}
		}

		let disableValues = ["не женат", "не замужем", "разведен", "разведена"];

		if (disableValues.includes(selectedValue)) {
			disableInputs(event, "disable");

			formGroup.classList.remove("js-hidden");
			input.dataset.disabled = "no";
		} else {
			disableInputs(event, "enable");
		}
	}
    //!SA-PROGRESS
}

function selectRadioInput(event) {
	let form = event.target.closest("form");
	let inputGroup = event.target.closest(".js-form-radio-section");
	let radioItems = inputGroup.querySelectorAll(".js-radio-item");
	let targetItem = event.target.closest(".js-radio-item");
	let value = targetItem.querySelector(".js-radio-value").innerText;
	let input = inputGroup.querySelector(".js-radio-input");

	input.value = value;

	for (const item of radioItems) {
		item.classList.remove("active");
	}

	let emailInput = form.querySelector(".email-input-group");
	let isContactRadio = inputGroup.classList.contains("js-contact-type");

	if (emailInput && isContactRadio) {
		let field = emailInput.querySelector(".input-field");

		if (value == "E-mail") {
			emailInput.classList.remove("js-hidden");
			field.classList.add("required");
		} else {
			emailInput.classList.add("js-hidden");
			field.classList.remove("required");
		}
	}

	targetItem.classList.add("active");
}

function toggleInputFocus(event) {
	let targetInput = event.target;
	let targetFormGroup = targetInput.closest(".js-form-group");

	let haveValue = Boolean(targetInput.value);

	if (!haveValue) {
		targetFormGroup.classList.toggle("focused");
	}

	targetFormGroup.classList.remove("error");
}

function toggleInputs(event) {
	let formGroup = event.target.closest(".js-form-group");
	let checkbox = event.target.closest(".js-input-checkbox");
	let conditionInput = formGroup.querySelector(".js-condition-input");
	let inputWrapper = formGroup.querySelector(".js-input-wrapper");
	let input = inputWrapper.querySelector("input");

	checkbox.classList.toggle("checked");
	formGroup.classList.toggle("disabled");
	inputWrapper.classList.toggle("js-hidden");

	let isDisabled = formGroup.classList.contains("disabled");

	input.dataset.disabled = isDisabled ? "yes" : "no";
	conditionInput.value = isDisabled ? "Нет" : "Да";
}

function toggleInputList(event) {
	let isDisabledValue = event.target.classList.contains(
		"js-disabled-input-value"
	);

	if (isDisabledValue) {
		return false;
	}

	let targetItem = event.target.closest(".js-form-group");
	let inputItems = document.querySelectorAll(".js-form-group");
	let isOpened = targetItem.classList.contains("opened");

	inputItems.forEach((el) => {
		el.classList.remove("opened");

		let input = el.querySelector(".js-input");

		if (!input) {
			return false;
		}

		let valueIsSelected = Boolean(input.value);

		if (!valueIsSelected) {
			el.classList.remove("focused");
		}
	});

	if (!isOpened) {
		targetItem.classList.add("opened");
		targetItem.classList.add("focused");
		targetItem.classList.remove("error");
	}

	// addOnClickListener("body", closeInputLists);
}

function closeInputLists(event = false) {
	if (event) {
		let isDisabledValue = event.target.classList.contains(
			"js-disabled-input-value"
		);

		if (isDisabledValue) {
			return false;
		}

		let isList = event.target.closest(".js-input-list");
		let isValue = event.target.classList.contains("js-select-input-list");

		if (isList && !isValue) {
			return false;
		}
	}

	let items = document.querySelectorAll(".js-form-group");

	items.forEach((el) => {
		let isOpened = el.classList.contains("opened");

		if (!isOpened) {
			return false;
		}

		el.classList.remove("opened");
		let targetInput = el.querySelector(".js-input");
		let valueIsSelected = Boolean(targetInput.value);

		if (!valueIsSelected) {
			el.classList.remove("focused");
		}
	});
}


function createOrder(event) {
  let ajaxData = {};

  let basketItems = basket.getStorage();

  let nameInput = document.querySelector('input[name="name"]');
  let phoneInput = document.querySelector('input[name="phone"]');

  ajaxData['name'] = nameInput.value;
  ajaxData['phone'] = phoneInput.value;
  ajaxData['email'] = '';

  ajaxData['products'] = [];

  for (const key in basketItems) {
    let basketItem = basketItems[key];

    for (const sizeKey in basketItem.sizes) {
      let size = basketItem['sizes'][sizeKey];

      if (size.quantity == 0) {
        continue;
      }

      let productData = {};

      productData.id = basketItem.id;
      productData.name = basketItem.name;
      productData.article = basketItem.article;
      productData.color_id = basketItem.color_id; 
      productData.color_name = basketItem.color_name; 
      productData.size_id = size.id; 
      productData.size_name = size.name; 
      productData.quantity = size.quantity;
      productData.price = basketItem.price;
      productData.total = basketItem.price * size.quantity;
      productData.img_src = basketItem.img_src;
      productData.url = basketItem.url;
      productData.combined_name = `${basketItem.name} (${size.name}, ${basketItem.color_name})`;

      ajaxData['products'].push(productData);
      orderProducts.push(productData);
    }
  }

  if (orderProducts.length == 0) {
    alert('Добавьте товары в корзину');
    return false;
  }

  orderCreateTries++;

  if (orderCreateTries > 3) {
    alert('Ошибка - превышено кол-во попыток оформить заказ');
    return false;
  }

  axios({
    method: 'post',
    url: '/index.php?route=checkout/order/create',
    data: ajaxData,
    headers: {'Content-Type': 'application/x-www-form-urlencoded'},
    responseType: 'json'
  })
    .then(function (response) {
      console.log(response);
      if (response.data.order_id) {
        orderNumber = response.data.order_id;
		lockFormEvent = false;
        sendFormWithErrorHandling(event);
      } else {
        alert('Ошибка при оформлении заказа, попробуйте повторно')
      }
    })
    .catch(function (error) {
      // insertElement.innerHTML = formErrorMessage;

      alert('Ошибка при оформлении заказа! Заказ не оформлен')
      console.log(error);
    });
}
