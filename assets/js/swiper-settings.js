const gallerySwiper = new Swiper('.js-gallery-swiper', {
  on: {
    init: function () {
      if (this.isLocked)
      {
        let prevBtn = document.querySelector('.js-gallery-swiper .js-slider-button-prev');
        let nextBtn = document.querySelector('.js-gallery-swiper .js-slider-button-next');
        prevBtn.classList.add('js-hidden');
        nextBtn.classList.add('js-hidden');
      };
    },
  },
  // Optional parameters
  loop: true,
  slidesPerView: 1,
  lazyPreloadPrevNext: 1,

  // Navigation arrows
  navigation: {
    nextEl: '.js-gallery-swiper .js-slider-button-next',
    prevEl: '.js-gallery-swiper .js-slider-button-prev',
  },

   pagination: {
      el: ".swiper-pagination",
        type: "fraction",
      clickable: true,
   },

  breakpoints: {
      // when window width is >= 320px
      320: {
        slidesPerView: 1,
        spaceBetween: 20
      },
      // when window width is >= 480px
      480: {
        slidesPerView: 1,
        spaceBetween: 30
      }
    }
});


//ANCHOR - similarEventsSwiper
const similarEventsSwiper = new Swiper('.js-similar-trips-swiper', {
  on: {
    init: function() {
      this.btnNext = document.querySelector('.js-similar-trips-slider-button-next');
      this.btnPrev = document.querySelector('.js-similar-trips-slider-button-prev');
      this.btnPrev.classList.add('js-hidden');

      if (!this.isLocked)
      {
        this.btnNext.classList.remove('js-hidden');
      };
    },
    reachBeginning: function() {
      this.btnPrev.classList.add('js-hidden');
    },
    reachEnd: function() {
      if(this.btnNext) {
        this.btnNext.classList.add('js-hidden');
      }
    },
    fromEdge: function() {
      this.btnNext.classList.remove('js-hidden');
      this.btnPrev.classList.remove('js-hidden');
    }
  },
  
  // Optional parameters
  loop: false,
  slidesPerView: 'auto',
  lazyPreloadPrevNext: 1,
  spaceBetween: 20,
  autoHeight: true,
  freeMode: true,

  navigation: {
    nextEl: '.js-similar-trips-slider-button-next',
    prevEl: '.js-similar-trips-slider-button-prev'
  },

  breakpoints: {
    1190: {
      slidesPerView: 4,
      spaceBetween: 20,
    }
  }
});

//ANCHOR - similarEventsSwiper2
const similarEventsSwiper2 = new Swiper('.js-similar-trips-swiper2', {
  on: {
    init: function() {
      this.btnNext = document.querySelector('.js-similar-trips-slider2-button-next');
      this.btnPrev = document.querySelector('.js-similar-trips-slider2-button-prev');
      this.btnPrev.classList.add('js-hidden');

      if (!this.isLocked)
      {
        this.btnNext.classList.remove('js-hidden');
      };
    },
    reachBeginning: function() {
      this.btnPrev.classList.add('js-hidden');
    },
    reachEnd: function() {
      if(this.btnNext) {
        this.btnNext.classList.add('js-hidden');
      }
    },
    fromEdge: function() {
      this.btnNext.classList.remove('js-hidden');
      this.btnPrev.classList.remove('js-hidden');
    }
  },
  
  // Optional parameters
  loop: false,
  slidesPerView: 'auto',
  lazyPreloadPrevNext: 1,
  spaceBetween: 20,
  autoHeight: true,
  freeMode: true,

  navigation: {
    nextEl: '.js-similar-trips-slider2-button-next',
    prevEl: '.js-similar-trips-slider2-button-prev'
  },

  breakpoints: {
    1190: {
      slidesPerView: 4,
      spaceBetween: 20,
    }
  }
});

//ANCHOR - reviewsImagesSwiper
const reviewsImagesSwiper = new Swiper('.js-reviews-images-swiper', {
  on: {
    init: function() {
      this.btnNext = document.querySelector('.js-reviews-images-swiper .js-slider-button-next');
      this.btnPrev = document.querySelector('.js-reviews-images-swiper .js-slider-button-prev');
      this.btnPrev.classList.add('js-hidden');

      if (!this.isLocked)
      {
        this.btnNext.classList.remove('js-hidden');
      };
    },
    reachBeginning: function() {
      this.btnPrev.classList.add('js-hidden');
    },
    reachEnd: function() {
      if(this.btnNext) {
        this.btnNext.classList.add('js-hidden');
      }
    },
    fromEdge: function() {
      this.btnNext.classList.remove('js-hidden');
      this.btnPrev.classList.remove('js-hidden');
    }
  },

  // Optional parameters
  loop: false,
  slidesPerView: 'auto',
  lazyPreloadPrevNext: 1,
  spaceBetween: 12,
  autoHeight: true,
  freeMode: true,

  navigation: {
    nextEl: '.js-reviews-images-swiper .js-slider-button-next',
    prevEl: '.js-reviews-images-swiper .js-slider-button-prev'
  },

  breakpoints: {
    1190: {
      slidesPerView: 5,
      spaceBetween: 19,
    },
    690: {
      spaceBetween: 19,
    }
  }

});


//ANCHOR - reviewsMessageImagesSwiperElement

const reviewsMessageImagesSwiperElement = '.js-reviews-message-images-slider'
const reviewsMessageImagesSwiperParams = {
  // on: {
  //   init: function() {
  //     this.btnNext = document.querySelector('.js-reviews-message-images-slider .js-slider-button-next');
  //     this.btnPrev = document.querySelector('.js-reviews-message-images-slider .js-slider-button-prev');
  //     this.btnPrev.classList.add('js-hidden');

  //     if (!this.isLocked)
  //     {
  //       this.btnNext.classList.remove('js-hidden');
  //     };
  //   },
  //   reachBeginning: function() {
  //     this.btnPrev.classList.add('js-hidden');
  //   },
  //   reachEnd: function() {
  //        if(this.btnNext) {
  //          this.btnNext.classList.add('js-hidden');
  //        }
   //   },
  //   fromEdge: function() {
  //     this.btnNext.classList.remove('js-hidden');
  //     this.btnPrev.classList.remove('js-hidden');
  //   }
  // },

  loop: false,
  slidesPerView: 'auto',
  freeMode: true,
  lazyPreloadPrevNext: 1,
  spaceBetween: 12,
};

function initReviewsMessageImagesSwiper() {
  let swiperElements = document.querySelectorAll(reviewsMessageImagesSwiperElement);

  swiperElements.forEach(el => {
    let reviewId = el.dataset.id;
    this['reviewsMessageImagesSwiper'+reviewId] = new Swiper(el, reviewsMessageImagesSwiperParams);
  });
  
}

initReviewsMessageImagesSwiper();



//ANCHOR - extendedTagsSwiper

const extendedTagsSwiper = new Swiper('.js-extended-tags-swiper', {
  on: {
    init: function() {
      this.btnNext = document.querySelector('.js-extended-tags-swiper .js-slider-button-next');
      this.btnPrev = document.querySelector('.js-extended-tags-swiper .js-slider-button-prev');
      this.btnPrev.classList.add('js-hidden');

      if (!this.isLocked)
      {
        this.btnNext.classList.remove('js-hidden');
      };
    },
    reachBeginning: function() {
      this.btnPrev.classList.add('js-hidden');
    },
    reachEnd: function() {
      if(this.btnNext) {
        this.btnNext.classList.add('js-hidden');
      }
    },
    fromEdge: function() {
      this.btnNext.classList.remove('js-hidden');
      this.btnPrev.classList.remove('js-hidden');
    }
  },

  loop: false,
  slidesPerView: 'auto',
  lazyPreloadPrevNext: 1,
  spaceBetween: 19,
  freeMode: true,
  navigation: {
    nextEl: '.js-extended-tags-swiper .js-slider-button-next',
    prevEl: '.js-extended-tags-swiper .js-slider-button-prev',
    enabled: false
  },

  scrollbar: {
    el: '.js-extended-tags-swiper-scrollbar',
    draggable: true
  },

  breakpoints: {
  // when window width is >= 1190px
    1190: {
      slidesPerView: 5,
      spaceBetween: 19,
      freeMode: false,
      navigation: {
        enabled: true
      },
    }
  },
});

//ANCHOR - filterItemsSwiper

const filterItemsSwiper = new Swiper('.js-filter-items-swiper', {
  // enabled: false,
  loop: false,
  slidesPerView: 'auto',
  spaceBetween: 10,
  freeMode: {
    enabled: true,
    // momentum: false
  },
  longSwipes: false,

  scrollbar: {
    el: '.js-filter-items-swiper-scrollbar',
    draggable: true
  },

  breakpoints: {
    900: {
      spaceBetween: 33,
    }, 
    750: {
      spaceBetween: 23,
    }
  },
});


//ANCHOR - articlesSwiper

const articlesSwiper = new Swiper('.js-articles-swiper', {
  enabled: true,
  loop: false,
  slidesPerView: 1,
  spaceBetween: 30,

  on: {
    init: function() {
      this.btnNext = document.querySelector('.js-articles-swiper .js-slider-button-next');
      this.btnPrev = document.querySelector('.js-articles-swiper .js-slider-button-prev');
      this.btnPrev.classList.add('js-hidden');

      if (!this.isLocked)
      {
        this.btnNext.classList.remove('js-hidden');
      };
    },
    reachBeginning: function() {
      this.btnPrev.classList.add('js-hidden');
    },
    reachEnd: function() {
      if(this.btnNext) {
        this.btnNext.classList.add('js-hidden');
      }
    },
    fromEdge: function() {
      if (this.btnNext) {
        this.btnNext.classList.remove('js-hidden');
      }
      if (this.btnPrev) {
        this.btnPrev.classList.remove('js-hidden');
      }
    }
  },

  navigation: {
    nextEl: '.js-articles-swiper .js-slider-button-next',
    prevEl: '.js-articles-swiper .js-slider-button-prev',
  },

  breakpoints: {
    441: {
      slidesPerView: 1,
      // enabled: false,
      spaceBetween: 0,
    } 
  }
});


//ANCHOR - homepageTextblockSwiper

const homepageTextblockSwiper = new Swiper('.js-homepage-textblock-swiper', {
  // enabled: true,
  loop: false,
  slidesPerView: 'auto',
  spaceBetween: 12,
  freeMode: true,

  on: {
    init: function() {
      this.btnNext = document.querySelector('.js-homepage-textblock-swiper .js-slider-button-next');
      this.btnPrev = document.querySelector('.js-homepage-textblock-swiper .js-slider-button-prev');

      if (this.btnPrev) {
        this.btnPrev.classList.add('js-hidden');
      }

      if (!this.isLocked)
      {
        this.btnNext.classList.remove('js-hidden');
      };
    },
    reachBeginning: function() {
      if (this.btnPrev) {
        this.btnPrev.classList.add('js-hidden');
      }
    },
    reachEnd: function() {
      if (this.btnNext) {
        this.btnNext.classList.add('js-hidden');
      }
    },
    fromEdge: function() {
      if (this.btnNext) {
        this.btnNext.classList.remove('js-hidden');
      }
      if (this.btnPrev) {
        this.btnPrev.classList.remove('js-hidden');
      }
    }
  },

  navigation: {
    nextEl: '.js-homepage-textblock-swiper .js-slider-button-next',
    prevEl: '.js-homepage-textblock-swiper .js-slider-button-prev',
  },

  breakpoints: {
    1190: {
      slidesPerView: 5,
      spaceBetween: 19,
    },
    690: {
      spaceBetween: 19,
    }
  }
});


//ANCHOR - filterItemsSwiper

const topBarSwiper = new Swiper('.js-top-bar-swiper', {
  // enabled: false,
  loop: false,
  slidesPerView: 'auto',
  spaceBetween: 20,
  freeMode: {
    enabled: true,
    // momentum: false
  },
  longSwipes: false,

  breakpoints: {
    1190: {
      spaceBetween: 0,
    }, 
    550: {
      spaceBetween: 43,
    }
  },
});


//ANCHOR - articlesSwiper
const mainArticlesSwiper = new Swiper('.js-main-articles-swiper', {
  on: {
    init: function() {
      this.btnNext = document.querySelector('.js-main-articles-slider-button-next');
      this.btnPrev = document.querySelector('.js-main-articles-slider-button-prev');
      this.btnPrev.classList.add('js-hidden');

      if (!this.isLocked)
      {
        this.btnNext.classList.remove('js-hidden');
      };
    },
    reachBeginning: function() {
      this.btnPrev.classList.add('js-hidden');
    },
    reachEnd: function() {
      if(this.btnNext) {
        this.btnNext.classList.add('js-hidden');
      }
    },
    fromEdge: function() {
      this.btnNext.classList.remove('js-hidden');
      this.btnPrev.classList.remove('js-hidden');
    }
  },
  
  // Optional parameters
  loop: false,
  slidesPerView: 'auto',
  lazyPreloadPrevNext: 1,
  spaceBetween: 20,
  autoHeight: true,
  freeMode: true,

  navigation: {
    nextEl: '.js-main-articles-slider-button-next',
    prevEl: '.js-main-articles-slider-button-prev'
  },

  breakpoints: {
    1190: {
      slidesPerView: 3,
      spaceBetween: 20,
    }
  }
});


//ANCHOR - shipsSwiper
const shipsSwiper = new Swiper('.js-ships-swiper', {
  on: {
    init: function() {
      this.btnNext = document.querySelector('.js-ships-slider-button-next');
      this.btnPrev = document.querySelector('.js-ships-slider-button-prev');
      this.btnPrev.classList.add('js-hidden');

      if (!this.isLocked)
      {
        this.btnNext.classList.remove('js-hidden');
      };
    },
    reachBeginning: function() {
      this.btnPrev.classList.add('js-hidden');
    },
    reachEnd: function() {
      if(this.btnNext) {
        this.btnNext.classList.add('js-hidden');
      }
    },
    fromEdge: function() {
      this.btnNext.classList.remove('js-hidden');
      this.btnPrev.classList.remove('js-hidden');
    }
  },
  
  // Optional parameters
  loop: false,
  slidesPerView: 'auto',
  lazyPreloadPrevNext: 1,
  spaceBetween: 20,
  autoHeight: true,
  freeMode: true,

  navigation: {
    nextEl: '.js-ships-slider-button-next',
    prevEl: '.js-ships-slider-button-prev'
  },

  breakpoints: {
    1190: {
      slidesPerView: 3,
      spaceBetween: 20,
    }
  }
});

const riverTripSwiper = new Swiper('.rivertrip-slider', {
  on: {
    init: function () {
      if (this.isLocked)
      {
        let prevBtn = document.querySelector('.js-gallery-swiper .js-slider-button-prev');
        let nextBtn = document.querySelector('.js-gallery-swiper .js-slider-button-next');

        if (prevBtn) {
          prevBtn.classList.add('js-hidden');
        }
        
        if (nextBtn) {
          nextBtn.classList.add('js-hidden');
        }
      };
    },
  },


  // Optional parameters
  loop: true,
  slidesPerView: 1,
  lazyPreloadPrevNext: 1,
    autoplay: {
            delay: 5000,
            disableOnInteraction: false
        },

  // Navigation arrows
  navigation: {
    nextEl: '.slider-button-next',
    prevEl: '.slider-button-prev',
  },

   pagination: {
      el: ".swiper-pagination",
      clickable: true,
   },


});