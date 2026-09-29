(function () {
  var root = document.documentElement;
  var cfg = window.SITE_CONFIG || {};

  /* ---- 1. 套用 config.js 的值 ---- */
  document.querySelectorAll('[data-config]').forEach(function (el) {
    var v = cfg[el.getAttribute('data-config')];
    if (v) { el.textContent = v; el.hidden = false; }
  });
  document.querySelectorAll('[data-config-href]').forEach(function (el) {
    var k = el.getAttribute('data-config-href'), v = cfg[k];
    if (v) el.href = (k === 'email' ? 'mailto:' : '') + v;
  });
  document.querySelectorAll('[data-config-block]').forEach(function (el) {
    el.hidden = !cfg[el.getAttribute('data-config-block')];
  });

  /* ---- 2. 語言切換 EN / 中 ---- */
  function setLang(l) {
    root.setAttribute('data-lang', l);
    root.lang = l === 'zh' ? 'zh-Hant' : 'en';
    try { localStorage.setItem('lang', l); } catch (e) {}
  }
  document.getElementById('langBtn').addEventListener('click', function () {
    setLang(root.getAttribute('data-lang') === 'zh' ? 'en' : 'zh');
  });

  /* ---- 3. 深色模式 ---- */
  document.getElementById('themeBtn').addEventListener('click', function () {
    var cur = root.getAttribute('data-theme') ||
      (matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light');
    var next = cur === 'dark' ? 'light' : 'dark';
    root.setAttribute('data-theme', next);
    try { localStorage.setItem('theme', next); } catch (e) {}
  });

  /* ---- 4. 手機選單 ---- */
  var btn = document.querySelector('.menu-btn'), nav = document.getElementById('nav');
  btn.addEventListener('click', function () {
    var open = nav.classList.toggle('open');
    btn.setAttribute('aria-expanded', open);
  });
  nav.querySelectorAll('a').forEach(function (a) {
    a.addEventListener('click', function () { nav.classList.remove('open'); btn.setAttribute('aria-expanded', false); });
  });

  /* ---- 5. 捲動時標示目前區段 ---- */
  var links = {};
  nav.querySelectorAll('a[href^="#"]').forEach(function (a) { links[a.getAttribute('href').slice(1)] = a; });
  if ('IntersectionObserver' in window) {
    var io = new IntersectionObserver(function (entries) {
      entries.forEach(function (en) {
        if (en.isIntersecting && links[en.target.id]) {
          Object.values(links).forEach(function (a) { a.classList.remove('active'); });
          links[en.target.id].classList.add('active');
        }
      });
    }, { rootMargin: '-45% 0px -50% 0px' });
    document.querySelectorAll('main section[id]').forEach(function (s) { io.observe(s); });
  }

  document.getElementById('year').textContent = new Date().getFullYear();
})();
