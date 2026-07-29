// Entry point: initializes all page modules on DOMContentLoaded

import { initTheme, initNavbarScroll } from './theme.js';
import { initFadeIn } from './animations.js';
import { initGalleryLightbox } from './gallery.js';
import { initCopyToClipboard } from './clipboard.js';
import { initBookingForm } from './booking.js';
import { initBackToTop, initProgressBar } from './scrollUtils.js';


document.addEventListener("DOMContentLoaded", () => {
    initTheme();
    initNavbarScroll();
    initFadeIn();
    initGalleryLightbox();
    initCopyToClipboard();
    initBookingForm();
    if (document.getElementById('backToTop')) 
        initBackToTop();
    
    if (document.getElementById('progressBar')) 
        initProgressBar();
});
