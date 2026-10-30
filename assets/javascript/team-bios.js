(() => {
  // Leave complete bios readable if Bootstrap or JavaScript is unavailable.
  if (!window.bootstrap || !window.bootstrap.Collapse) return;
  const previewCharacterLimit = 335;

  document.querySelectorAll('.team-members__bio').forEach((bio) => {
    const button = bio.nextElementSibling;
    const preview = bio.querySelector('p').cloneNode(true);
    const fullText = preview.textContent.trim();
    const characters = Array.from(fullText);
    if (characters.length <= previewCharacterLimit) return;
    let introduction = characters.slice(0, previewCharacterLimit).join('');
    // Keep a consistent text budget without cutting the final word in half.
    if (!/\s/.test(characters[previewCharacterLimit])) {
      const lastWordBoundary = introduction.search(/\s+\S*$/);
      if (lastWordBoundary > 0) introduction = introduction.slice(0, lastWordBoundary);
    }
    preview.textContent = `${introduction.trimEnd()}…`;
    preview.classList.add('team-members__preview');
    bio.before(preview);
    bio.classList.add('collapse');

    const updateButton = (expanded) => {
      const label = expanded ? 'Read less' : 'Read more';
      button.textContent = label;
      button.setAttribute('aria-label', `${label} about ${button.dataset.memberName}`);
      button.setAttribute('aria-expanded', String(expanded));
    };

    updateButton(false);
    button.hidden = false;
    bio.addEventListener('show.bs.collapse', () => {
      preview.hidden = true;
      updateButton(true);
    });
    bio.addEventListener('hidden.bs.collapse', () => {
      preview.hidden = false;
      updateButton(false);
    });
  });
})();
