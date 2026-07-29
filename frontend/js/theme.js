// Theme toggle (dark/light mode) and navbar scroll behavior

export function initTheme() {
    const themeToggleBtn = document.getElementById('theme-toggle');
    const body = document.body;
    const thumb = themeToggleBtn.querySelector('.toggle-thumb');
    const defaultTheme = 'dark';
    let currentTheme = localStorage.getItem('theme') || defaultTheme;

    function applyTheme(theme) {
        const isDark = theme === 'dark';
        body.classList.toggle('dark-mode', isDark);
        themeToggleBtn.classList.toggle('dark', isDark);
        themeToggleBtn.classList.toggle('light', !isDark);
        if (thumb) {
            thumb.classList.toggle('dark', isDark);
            thumb.classList.toggle('light', !isDark);
        }
        localStorage.setItem('theme', theme);
    }

    applyTheme(currentTheme);

    themeToggleBtn.addEventListener('click', () => {
        const isDark = body.classList.contains('dark-mode');
        applyTheme(isDark ? 'light' : 'dark');
    });
}

export function initNavbarScroll() {
    const navbar = document.getElementById('navbar');
    window.addEventListener('scroll', () => {
        navbar.classList.toggle('scrolled', window.scrollY > 50);
    });
}
