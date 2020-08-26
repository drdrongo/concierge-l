// core version + navigation, pagination modules:
import Swiper, { Navigation, Pagination } from 'swiper';

// configure Swiper to use modules
Swiper.use([Navigation, Pagination]);

const initSwiper = () => {
  const myCategories = ['Essentials', 'Requests', 'Bed & Bath', 'Kitchen', 'Other'];
  var mySwiper = new Swiper('.swiper-container', {
    // Optional parameters
    loop: true,
    
    pagination: {
      el: '.swiper-pagination',
      clickable: true,
      renderBullet: function (index, className) {
        return '<span class="' + className + '">' + myCategories[index] + '</span>';
      },
    },

    // Navigation arrows
    navigation: {
      nextEl: '.swiper-button-next',
      prevEl: '.swiper-button-prev',
    }
  });
};

export { initSwiper };