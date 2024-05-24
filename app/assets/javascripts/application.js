//= require rails-ujs
//= require_tree .

document.addEventListener('DOMContentLoaded', () => {
    const tabLinks = document.querySelectorAll('.tab-links a');
    const tabs = document.querySelectorAll('.tab');

    tabLinks.forEach(link => {
        link.addEventListener('click', event => {
            event.preventDefault();

            tabLinks.forEach(link => link.parentElement.classList.remove('active'));
            tabs.forEach(tab => tab.classList.remove('active'));

            const tabId = link.getAttribute('href').substring(1);
            link.parentElement.classList.add('active');
            document.getElementById(tabId).classList.add('active');
        });
    });
});
