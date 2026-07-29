// Copy-to-clipboard for elements with a data-copy attribute (e.g. contact info)

export function initCopyToClipboard() {
    document.querySelectorAll('[data-copy]').forEach(el => {
        el.addEventListener('click', () => {
            navigator.clipboard.writeText(el.dataset.copy);
            const feedback = el.querySelector('.copy-feedback');
            feedback.classList.add('show');
            setTimeout(() => feedback.classList.remove('show'), 1200);
        });
    });
}
