//ANCHOR - HYSTMODAL

const Hystmodal = new HystModal({
  linkAttributeName: "data-hystmodal",
  backscroll: false,
  beforeOpen: function(modal){
    let modalWindow = modal.openedWindow.querySelector('.hystmodal__window');
    let isMobileMenu = modalWindow.classList.contains('js-mobile-menu');
    let scrollableElement = isMobileMenu ? modalWindow : modal.openedWindow;
    
    disableScroll(scrollableElement);

    let body = document.querySelector('body');
    body.classList.add('opened-modal');

    let src = modal.starter ? modal.starter.dataset.fullImg : false;

    if (src) {
      let image = modal.openedWindow.querySelector('img');      
      image.setAttribute('src', removeDoubleSlashes(src));
    }

    let resourceName = modal.starter ? modal.starter.dataset.name : false;
    let resourceNameElement = document.querySelector('.js-resource-name');

    if (resourceName && resourceNameElement) {
      resourceNameElement.innerHTML = resourceName;
    }
  },
  afterClose: function(modal){
    let modalWindow = modal.openedWindow.querySelector('.hystmodal__window');
    let isMobileMenu = modalWindow.classList.contains('js-mobile-menu');
    let scrollableElement = isMobileMenu ? modalWindow : modal.openedWindow;

    enableScroll(scrollableElement);

    let body = document.querySelector('body');
    body.classList.remove('opened-modal');

    let src = modal.starter ? modal.starter.dataset.fullImg : false;
    if (src) {
      let image = modal.openedWindow.querySelector('img');      
      image.setAttribute('src', '');

    }
  },
});

function disableScroll(scrollableElement) {
  scrollLock.disablePageScroll(scrollableElement);
  scrollLock.addFillGapSelector('body');
  scrollLock.addFillGapSelector('.fixed-bar');
}


function enableScroll(scrollableElement) {
  scrollLock.enablePageScroll(scrollableElement);
  scrollLock.removeFillGapSelector('body');
  scrollLock.removeFillGapSelector('.fixed-bar');
}