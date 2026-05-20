"use strict";

let easyComm = {
    selectors: {
        form: 'form.ec-form',
        submit: 'input[type="submit"]'
    },
    classes: {

    },
    initialize: function(){
        easyComm.rating.initialize();
        easyComm.files.initialize();
        // Обработчик отправки формы
        document.querySelectorAll(easyComm.selectors.form).forEach( function(el) {
            el.addEventListener('submit', function(e) {
                var form = e.target || e.srcElement;
                easyComm.message.send(form);
                e.preventDefault();
                return false;
            });
        });
        // Обработчик голосования
        document.querySelectorAll('.js-ec-vote-button').forEach( function(el) {
            el.addEventListener('click', function(e) {
                e.preventDefault();
                var btn = e.target || e.srcElement;
                easyComm.message.vote(btn);
            });
        });
    },

    message: {
        send: function(form) {

            // предварительно очищаем форму (ошибки)
            form.querySelector(easyComm.selectors.submit).setAttribute('disabled', 'disabled');
            form.querySelectorAll('.has-error').forEach( function(el) { el.classList.remove("has-error"); } );
            form.querySelectorAll('.ec-error').forEach( function(el) { el.innerHTML = ""; el.style.display = "none"; } );

            // отправляем запрос при голосовании

            var formData = new FormData(form);
            formData.append('action', 'message/create');

            var xmlHttpRequest = new XMLHttpRequest();
            xmlHttpRequest.onreadystatechange = function() {
                if (xmlHttpRequest.readyState === XMLHttpRequest.DONE) {   // XMLHttpRequest.DONE == 4
                    if (xmlHttpRequest.status === 200) {
                        var response = JSON.parse(xmlHttpRequest.responseText);
                        var fid = form.getAttribute('data-fid');
                        form.querySelector(easyComm.selectors.submit).disabled = false;
                        if (response.success) {
                            form.reset();
                            if(typeof (response.data) == "string") {
                                document.getElementById('ec-form-success-' + fid).innerHTML = response.data;
                                form.style.display = "none";
                            }
                            else {
                                easyComm.notice.show(response.message);
                            }
                        }
                        else {
                            if(response.data && response.data.length) {
                                for(var i = 0; i < response.data.length; i++){
                                    var error = response.data[i];
                                    var inputGroup = form.querySelector('[name="' + error.field + '"]').closest('.form-group');
                                    if(inputGroup) {
                                        inputGroup.classList.add('has-error');
                                        var errorEl = form.querySelector('#ec-' + error.field + '-error-' + fid);
                                        if(errorEl) {
                                            errorEl.innerHTML = error.message;
                                            errorEl.style.display = 'block';
                                        }
                                    }
                                }
                            } else {
                                easyComm.notice.error(response.message);
                            }
                        }
                    }
                    else {
                        easyComm.notice.error('Submit error');
                        form.querySelector(easyComm.selectors.submit).disabled = false;
                    }
                }
            };

            xmlHttpRequest.open("POST", easyCommConfig.actionUrl, true);
            xmlHttpRequest.send(formData);
        },
        vote: function(btn) {
            if(btn.getAttribute("data-locked")) {
                return;
            }
            var messageId = btn.closest('.ec-message__votes').getAttribute('data-message-id');
            var value = btn.getAttribute('data-value');
            var propertiesKey = btn.closest('.ec-message__votes').getAttribute('data-properties-key');

            // блокируем от повторного нажатия
            btn.setAttribute('data-locked', 'true');

            // отправляем запрос при голосовании
            var data = [];
            data.push("action=" + encodeURIComponent("message/vote"));
            data.push("messageId=" + encodeURIComponent(messageId));
            data.push("propertiesKey=" + encodeURIComponent(propertiesKey));
            data.push("value=" + encodeURIComponent(value));

            data = data.join("&");

            var xmlHttpRequest = new XMLHttpRequest();
            xmlHttpRequest.onreadystatechange = function() {
                if (xmlHttpRequest.readyState === XMLHttpRequest.DONE) {   // XMLHttpRequest.DONE == 4
                    if (xmlHttpRequest.status === 200) {
                        var response = JSON.parse(xmlHttpRequest.responseText);
                        if(response.success) {
                            var wrapper = btn.closest('.ec-message__votes');
                            wrapper.querySelectorAll('.js-ec-vote-button').forEach( function(el) { el.classList.remove("active"); } );
                            wrapper.querySelector('.js-ec-vote-button[data-value="1"]').innerHTML = response.data.likes;
                            wrapper.querySelector('.js-ec-vote-button[data-value="-1"]').innerHTML = response.data.dislikes;
                            wrapper.querySelector('.js-ec-vote-bar').style.width = response.data.votes_rating_percent + '%';
                            if(response.data.value) {
                                wrapper.querySelector('.js-ec-vote-button[data-value="' + response.data.value + '"]').classList.add('active');
                            }
                        }
                        else {
                            easyComm.notice.error(response.message);
                        }
                        btn.removeAttribute('data-locked');
                    }
                    else {
                        easyComm.notice.error('Request error');
                        btn.removeAttribute('data-locked');
                    }
                }
            };

            xmlHttpRequest.open("POST", easyCommConfig.actionUrl, true);
            xmlHttpRequest.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
            xmlHttpRequest.send(data);
        }
    },


    rating: {
        initialize: function(){
            var stars = document.querySelectorAll('.ec-rating-stars > span');

            // Добавляем звездам в форме события нажатия на них и наведения курсора мыши
            stars.forEach(function(star) {
                star.addEventListener('click', function(e) {
                    var el = e.target || e.srcElement;
                    var starDesc = el.getAttribute('data-description');
                    var descElement = el.parentNode.parentNode.querySelector('.ec-rating-description');
                    descElement.innerHTML = starDesc;
                    descElement.setAttribute('data-old-text', starDesc);

                    el.parentNode.querySelectorAll('span').forEach(function(span) {span.classList.remove('active','active2','active-disabled')});

                    el.classList.add('active');
                    var prevEl = el.previousElementSibling;
                    while(prevEl !== null) {
                        prevEl.classList.add('active');
                        prevEl = prevEl.previousElementSibling;
                    }

                    // store to hidden input
                    var storageId = el.closest('.ec-rating').getAttribute('data-storage-id');
                    document.getElementById(storageId).value = el.getAttribute('data-rating');
                });

                star.addEventListener('mouseenter', function(e) {
                    var hoverEl = e.target || e.srcElement;
                    var descriptionElement = hoverEl.parentNode.parentNode.querySelector('.ec-rating-description');
                    var oldText = descriptionElement.innerHTML;
                    descriptionElement.setAttribute("data-old-text", oldText);
                    descriptionElement.innerHTML = hoverEl.getAttribute('data-description');
                    hoverEl.classList.add('active2');
                    hoverEl.classList.remove('active-disabled');

                    // prev stars
                    var prevEl = hoverEl.previousElementSibling;
                    while(prevEl !== null) {
                        prevEl.classList.add('active2');
                        prevEl.classList.remove('active-disabled');
                        prevEl = prevEl.previousElementSibling;
                    }
                    // next stars
                    var nextEl = hoverEl.nextElementSibling;
                    while(nextEl !== null) {
                        nextEl.classList.remove('active2');
                        nextEl.classList.add('active-disabled');
                        nextEl = nextEl.nextElementSibling;
                    }
                });
                star.addEventListener('mouseleave', function(e) {
                    var hoverEl = e.target || e.srcElement;
                    var descriptionElement = hoverEl.parentNode.parentNode.querySelector('.ec-rating-description');
                    descriptionElement.innerHTML = descriptionElement.getAttribute("data-old-text");
                    hoverEl.parentNode.querySelectorAll('span').forEach(function(el) { el.classList.remove("active2", "active-disabled"); } );
                });

            });

        }
    },

    files: {
        initialize: function(){
            var inputElements = document.querySelectorAll(easyComm.selectors.form + ' ' +'input[name="files[]"]');
            inputElements.forEach( function(el) {
                el.addEventListener('change', function(e) {

                    var inputElement = e.target || e.srcElement;
                    var files = inputElement.files;

                    var errorElement = inputElement.parentNode.querySelector('.ec-error');
                    errorElement.innerHTML = "";
                    errorElement.style.display = "none";
                    errorElement.closest('.form-group').classList.remove('has-error');

                    // Request
                    var data = [];
                    data.push(encodeURIComponent("action") + "=" + encodeURIComponent("message/check-files"));
                    data.push(encodeURIComponent("thread") + "=" + encodeURIComponent(inputElement.closest('form').querySelector('input[name="thread"]').value));

                    for (var i = 0; i < files.length; i++) {
                        data.push(encodeURIComponent("files[" + i + "][name]") + "=" + encodeURIComponent(files.item(i).name));
                        data.push(encodeURIComponent("files[" + i + "][size]") + "=" + encodeURIComponent(files.item(i).size));
                    }

                    data = data.join("&");

                    var xmlHttpRequest = new XMLHttpRequest();
                    xmlHttpRequest.onreadystatechange = function() {
                        if (xmlHttpRequest.readyState === XMLHttpRequest.DONE) {   // XMLHttpRequest.DONE == 4
                            if (xmlHttpRequest.status === 200) {
                                var response = JSON.parse(xmlHttpRequest.responseText);
                                if(response.success) {
                                    if(response.data.length && response.data.length > 0) {
                                        errorElement.innerHTML = response.data.join("<br />");
                                        // TODO: inline или block?
                                        errorElement.style.display = "block";
                                        errorElement.closest('.form-group').classList.add('has-error');
                                    }
                                }
                                else {
                                    easyComm.notice.error(response.message);
                                }
                            }
                            else {
                                easyComm.notice.error('Request error');
                            }
                        }
                    };

                    xmlHttpRequest.open("POST", easyCommConfig.actionUrl, true);
                    xmlHttpRequest.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
                    xmlHttpRequest.send(data);

                });
            }); // forEach
        }
    },

    notice: {
        error: function(text) {
            alert(text);
        },
        show: function(text) {
            alert(text);
        }
    }
};

document.addEventListener("DOMContentLoaded", function(event) {
    easyComm.initialize();
});

var easyCommReCaptchaCallback = function() {
    if(typeof grecaptcha !== 'undefined'){
        document.querySelectorAll('.ec-captcha').forEach(function(el){
            grecaptcha.render(el.id, {
                'sitekey' : easyCommConfig.reCaptchaSiteKey
            });
        });
    }
    else {
        easyComm.notice.error('grecaptcha is not defined!');
    }
};