// Gallery lightbox: click an image to view it in a fullscreen overlay

export function initGalleryLightbox() {
    document.querySelectorAll('.gallery img').forEach(img => {
        img.addEventListener('click', () => {
            const overlay = document.createElement('div');
            overlay.className = 'lightbox-overlay';
            const clone = document.createElement('img');
            clone.src = img.src;
            clone.alt = img.alt;
            overlay.appendChild(clone);
            document.body.appendChild(overlay);

            requestAnimationFrame(() => overlay.classList.add('active'));

            overlay.addEventListener('click', () => {
                overlay.classList.remove('active');
                setTimeout(() => overlay.remove(), 300);
            });
        });
    });
}
