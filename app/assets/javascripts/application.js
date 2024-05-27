//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .

document.addEventListener('DOMContentLoaded', function() {
    // Form submission confirmation
    document.querySelectorAll('form').forEach(function(form) {
        form.addEventListener('submit', function(event) {
            var confirmMessage = form.querySelector('input[type="submit"]').getAttribute('data-confirm');
            if (confirmMessage && !confirm(confirmMessage)) {
                event.preventDefault();
            }
        });
    });

    // Tab switching functionality
    const tabs = document.querySelectorAll('.tab-links li a');
    const tabContents = document.querySelectorAll('.tab-content');

    tabs.forEach((tab) => {
        tab.addEventListener('click', (event) => {
            event.preventDefault();
            tabs.forEach(tab => tab.parentElement.classList.remove('active'));
            tabContents.forEach(content => content.classList.remove('active'));

            tab.parentElement.classList.add('active');
            const activeTabContent = document.querySelector(tab.getAttribute('href'));
            if (activeTabContent) {
                activeTabContent.classList.add('active');
            }
        });
    });
});
