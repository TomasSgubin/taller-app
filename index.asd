<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">
<title>Suspensión Walter — Clientes</title>
<script src="https://cdn.jsdelivr.net/npm/@supabase/supabase-js@2/dist/umd/supabase.js"></script>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Oswald:wght@500;600;700&display=swap" rel="stylesheet">
<style>
  :root {
    --bg: #F4F4F4;
    --panel: #FFFFFF;
    --panel-2: #F1F1F1;
    --ink: #1F1F1F;
    --ink-soft: #55575A;
    --ink-faint: #8B8D90;
    --line: #E2E2E2;
    --line-strong: #C9C9CB;
    --accent: #C8102E;
    --accent-ink: #8A0A1F;
    --accent-bg: #F9DDE1;
    --danger: #C8102E;
    --danger-bg: #F9DDE1;
    --danger-ink: #8A0A1F;
    --ok: #4D6E3A;
    --ok-bg: #E4EBD9;
    --radius: 10px;
    box-sizing: border-box;
    padding-top: env(safe-area-inset-top, 0px);
    padding-bottom: env(safe-area-inset-bottom, 0px);
  }
  @media (prefers-color-scheme: dark) {
    :root:not([data-theme="light"]) {
      --bg: #161616; --panel: #212121; --panel-2: #2A2A2A; --ink: #F2F2F2;
      --ink-soft: #B5B7BA; --ink-faint: #85878B; --line: #333333; --line-strong: #454545;
      --accent: #E5384F; --accent-ink: #FFD3D9; --accent-bg: #3D1A20;
      --danger: #E5384F; --danger-bg: #3D1A20; --danger-ink: #FFD3D9;
      --ok: #8FB374; --ok-bg: #26301F;
    }
  }
  :root[data-theme="dark"] {
    --bg: #161616; --panel: #212121; --panel-2: #2A2A2A; --ink: #F2F2F2;
      --ink-soft: #B5B7BA; --ink-faint: #85878B; --line: #333333; --line-strong: #454545;
      --accent: #E5384F; --accent-ink: #FFD3D9; --accent-bg: #3D1A20;
      --danger: #E5384F; --danger-bg: #3D1A20; --danger-ink: #FFD3D9;
      --ok: #8FB374; --ok-bg: #26301F;
  }
  html { scroll-padding-top: env(safe-area-inset-top, 0px); height: 100%; }
  * { box-sizing: border-box; }
  body {
    margin: 0; min-height: 100%; background: var(--bg); color: var(--ink);
    font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif;
    -webkit-font-smoothing: antialiased;
  }
  header {
    position: sticky; top: 0; z-index: 20; background: var(--bg);
    border-bottom: 1px solid var(--line); padding: calc(14px + env(safe-area-inset-top, 0px)) 16px 12px;
  }
  .brand-row { display: flex; align-items: baseline; justify-content: space-between; gap: 10px; }
  .brand { font-family: 'Oswald', 'Arial Narrow', Arial, sans-serif; text-transform: uppercase; font-size: 21px; font-weight: 700; letter-spacing: 0.04em; display: flex; align-items: baseline; gap: 8px; }
  .brand .mark { display: inline-block; width: 9px; height: 9px; background: var(--accent); border-radius: 1px; position: relative; top: -1px; }
  .subtitle { font-size: 12.5px; color: var(--ink-faint); margin-top: 2px; }
  .logout-btn { background: none; border: none; color: var(--ink-faint); font-size: 12.5px; text-decoration: underline; cursor: pointer; padding: 4px; }
  .searchbar { margin-top: 12px; position: relative; }
  .searchbar input {
    width: 100%; padding: 10px 12px 10px 34px; border-radius: var(--radius);
    border: 1px solid var(--line-strong); background: var(--panel); color: var(--ink); font-size: 15px;
  }
  .searchbar input:focus { outline: 2px solid var(--accent); outline-offset: -1px; }
  .searchbar svg { position: absolute; left: 10px; top: 50%; transform: translateY(-50%); opacity: 0.5; }
  main { padding: 14px 16px 100px; max-width: 720px; margin: 0 auto; }
  .fab {
    position: fixed; right: 20px; bottom: calc(20px + env(safe-area-inset-bottom, 0px)); z-index: 30;
    width: 56px; height: 56px; border-radius: 50%; background: var(--accent); color: #fff; border: none;
    box-shadow: 0 4px 14px rgba(0,0,0,0.22); font-size: 28px; line-height: 1; cursor: pointer;
    display: flex; align-items: center; justify-content: center;
  }
  .fab:active { transform: scale(0.96); }
  .empty { text-align: center; padding: 60px 20px; color: var(--ink-faint); }
  .empty .big { font-size: 40px; margin-bottom: 10px; }
  .empty h3 { color: var(--ink-soft); font-weight: 600; margin: 0 0 6px; font-size: 16px; }
  .empty p { margin: 0; font-size: 13.5px; }
  .client-card {
    background: var(--panel); border: 1px solid var(--line); border-radius: 12px;
    padding: 14px; margin-bottom: 10px; cursor: pointer;
  }
  .client-top { display: flex; justify-content: space-between; align-items: flex-start; gap: 10px; }
  .client-name { font-size: 16.5px; font-weight: 600; }
  .client-phone { font-size: 13px; color: var(--ink-soft); margin-top: 3px; }
  .client-meta { font-size: 12.5px; color: var(--ink-faint); margin-top: 8px; display: flex; gap: 14px; flex-wrap: wrap; }
  .chevron { color: var(--ink-faint); flex-shrink: 0; margin-top: 2px; }
  .badge { display: inline-flex; align-items: center; gap: 5px; font-size: 12px; }
  .backbtn { display: inline-flex; align-items: center; gap: 6px; background: none; border: none; color: var(--ink-soft); font-size: 14px; cursor: pointer; padding: 6px 0; margin-bottom: 6px; }
  .detail-header { background: var(--panel); border: 1px solid var(--line); border-radius: 12px; padding: 16px; margin-bottom: 16px; }
  .detail-name { font-family: 'Oswald', 'Arial Narrow', Arial, sans-serif; font-size: 22px; font-weight: 600; letter-spacing: 0.02em; }
  .detail-row { display: flex; align-items: center; gap: 8px; margin-top: 8px; font-size: 14.5px; color: var(--ink-soft); }
  .detail-row a { color: var(--accent); text-decoration: none; }
  .detail-actions { display: flex; gap: 8px; margin-top: 14px; }
  .section-head { display: flex; justify-content: space-between; align-items: center; margin: 22px 0 10px; }
  .section-head h2 { font-family: 'Oswald', 'Arial Narrow', Arial, sans-serif; font-size: 14px; text-transform: uppercase; letter-spacing: 0.04em; color: var(--ink-faint); font-weight: 700; margin: 0; }
  .car-card { background: var(--panel); border: 1px solid var(--line); border-radius: 12px; padding: 14px; margin-bottom: 10px; cursor: pointer; }
  .car-top { display: flex; justify-content: space-between; align-items: center; gap: 10px; }
  .car-title { font-weight: 600; font-size: 15.5px; }
  .plate { font-family: ui-monospace, SFMono-Regular, Menlo, monospace; font-size: 12.5px; background: var(--panel-2); border: 1px solid var(--line); border-radius: 5px; padding: 2px 7px; letter-spacing: 0.03em; color: var(--ink-soft); }
  .car-sub { font-size: 12.5px; color: var(--ink-faint); margin-top: 4px; }
  .repair-item { border-left: 2px solid var(--line-strong); padding: 2px 0 14px 16px; position: relative; margin-left: 4px; }
  .repair-item::before { content: ''; position: absolute; left: -5px; top: 3px; width: 8px; height: 8px; border-radius: 50%; background: var(--accent); }
  .repair-item:last-child { padding-bottom: 0; }
  .repair-date { font-size: 12px; color: var(--ink-faint); font-weight: 600; }
  .repair-desc { font-size: 14.5px; margin-top: 3px; line-height: 1.45; }
  .repair-foot { display: flex; gap: 14px; margin-top: 5px; font-size: 12.5px; color: var(--ink-soft); }
  .repair-actions { margin-top: 6px; }
  .link-btn { background: none; border: none; padding: 0; font-size: 12.5px; color: var(--ink-faint); cursor: pointer; text-decoration: underline; }
  .link-btn.danger { color: var(--danger); }
  button.plain { background: var(--panel-2); border: 1px solid var(--line-strong); color: var(--ink); border-radius: 8px; padding: 8px 14px; font-size: 13.5px; font-weight: 600; cursor: pointer; }
  button.plain.accent { background: var(--accent-bg); color: var(--accent-ink); border-color: var(--accent-bg); }
  button.plain.danger { background: var(--danger-bg); color: var(--danger-ink); border-color: var(--danger-bg); }
  button.plain:active { transform: scale(0.98); }
  button.plain:disabled { opacity: 0.6; cursor: default; }
  .overlay { position: fixed; inset: 0; background: rgba(20,18,14,0.45); z-index: 50; display: flex; align-items: flex-end; justify-content: center; }
  @media (min-width: 600px) { .overlay { align-items: center; } }
  .sheet { background: var(--panel); width: 100%; max-width: 480px; border-radius: 16px 16px 0 0; padding: 20px 20px calc(20px + env(safe-area-inset-bottom, 0px)); max-height: 88vh; overflow-y: auto; }
  @media (min-width: 600px) { .sheet { border-radius: 16px; max-height: 80vh; } }
  .sheet h3 { font-family: 'Oswald', 'Arial Narrow', Arial, sans-serif; margin: 0 0 16px; font-size: 19px; font-weight: 600; letter-spacing: 0.03em; text-transform: uppercase; }
  .field { margin-bottom: 13px; }
  .field label { display: block; font-size: 12.5px; font-weight: 600; color: var(--ink-soft); margin-bottom: 5px; }
  .field input, .field textarea {
    width: 100%; padding: 10px 11px; border-radius: 8px; border: 1px solid var(--line-strong);
    background: var(--panel-2); color: var(--ink); font-size: 15px; font-family: inherit;
  }
  .field textarea { resize: vertical; min-height: 64px; }
  .field input:focus, .field textarea:focus { outline: 2px solid var(--accent); outline-offset: -1px; }
  .field-row { display: flex; gap: 10px; }
  .field-row .field { flex: 1; }
  .sheet-actions { display: flex; gap: 10px; margin-top: 6px; }
  .sheet-actions button { flex: 1; padding: 12px; font-size: 14.5px; }
  .err { color: var(--danger); font-size: 12px; margin-top: 4px; display: none; }
  .err.show { display: block; }
  .sr-only { position: absolute; width: 1px; height: 1px; padding: 0; margin: -1px; overflow: hidden; clip: rect(0,0,0,0); white-space: nowrap; border: 0; }

  /* Login screen */
  .login-wrap { min-height: 100vh; display: flex; align-items: center; justify-content: center; padding: 20px; }
  .login-box { background: var(--panel); border: 1px solid var(--line); border-radius: 14px; padding: 28px 24px; width: 100%; max-width: 360px; }
  .login-box .brand { justify-content: center; margin-bottom: 4px; }
  .login-sub { text-align: center; color: var(--ink-faint); font-size: 13px; margin-bottom: 22px; }
  .spinner { text-align: center; padding: 60px 20px; color: var(--ink-faint); font-size: 14px; }
</style>
</head>
<body>
<h1 class="sr-only">Gestión de clientes, vehículos y reparaciones del taller</h1>

<div id="app"><div class="spinner">Cargando…</div></div>
<div id="modalRoot"></div>

<script>
(function(){
  // ====== CONFIGURACIÓN DE SUPABASE ======
  var SUPABASE_URL = 'https://bzwzozkwtrukxfswwvpy.supabase.co';
  var SUPABASE_KEY = 'sb_publishable_8AF3DhOb2DZrE6o__NIwxw_Ljt8f2ze';
  // ========================================

  var sb = supabase.createClient(SUPABASE_URL, SUPABASE_KEY);

  var data = { clientes: [], autos: [], reparaciones: [] };
  var view = { screen: 'list', clienteId: null, search: '' };
  var session = null;

  function esc(s){
    return String(s == null ? '' : s).replace(/[&<>"']/g, function(c){
      return {'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'}[c];
    });
  }
  function fmtMoney(n){
    if(n === '' || n === null || n === undefined || isNaN(n)) return '';
    return '$' + Number(n).toLocaleString('es-AR');
  }
  function fmtDate(iso){
    if(!iso) return '';
    var parts = iso.split('-');
    if(parts.length !== 3) return iso;
    return parts[2] + '/' + parts[1] + '/' + parts[0];
  }
  function todayISO(){
    var d = new Date();
    return d.getFullYear() + '-' + String(d.getMonth()+1).padStart(2,'0') + '-' + String(d.getDate()).padStart(2,'0');
  }
  function autosDeCliente(clienteId){ return data.autos.filter(function(a){ return a.cliente_id === clienteId; }); }
  function reparacionesDeAuto(autoId){
    return data.reparaciones.filter(function(r){ return r.auto_id === autoId; })
      .sort(function(a,b){ return (b.fecha||'').localeCompare(a.fecha||''); });
  }

  function showError(err){
    console.error(err);
    alert('Ocurrió un error al comunicarse con la base de datos:\n' + (err && err.message ? err.message : err));
  }

  // ---------- AUTENTICACIÓN ----------
  function renderLogin(errorMsg){
    document.getElementById('app').innerHTML =
      '<div class="login-wrap"><div class="login-box">' +
        '<div class="brand"><span class="mark"></span>Suspensión Walter</div>' +
        '<div class="login-sub">Ingresá con tu cuenta</div>' +
        '<div class="field"><label for="loginEmail">Email</label><input id="loginEmail" type="email" autocomplete="username"></div>' +
        '<div class="field"><label for="loginPass">Contraseña</label><input id="loginPass" type="password" autocomplete="current-password"></div>' +
        '<div class="err' + (errorMsg ? ' show' : '') + '" id="loginErr">' + esc(errorMsg || 'Email o contraseña incorrectos.') + '</div>' +
        '<button class="plain accent" id="loginBtn" style="width:100%;padding:12px;margin-top:8px;">Entrar</button>' +
      '</div></div>';

    function doLogin(){
      var email = document.getElementById('loginEmail').value.trim();
      var pass = document.getElementById('loginPass').value;
      var btn = document.getElementById('loginBtn');
      btn.disabled = true; btn.textContent = 'Entrando…';
      sb.auth.signInWithPassword({ email: email, password: pass }).then(function(res){
        if(res.error){
          btn.disabled = false; btn.textContent = 'Entrar';
          renderLogin(res.error.message);
          return;
        }
        session = res.data.session;
        boot();
      });
    }
    document.getElementById('loginBtn').addEventListener('click', doLogin);
    document.getElementById('loginPass').addEventListener('keydown', function(e){ if(e.key === 'Enter') doLogin(); });
  }

  function renderShell(){
    document.getElementById('app').innerHTML =
      '<header>' +
        '<div class="brand-row">' +
          '<div><div class="brand"><span class="mark"></span>Suspensión Walter</div><div class="subtitle" id="clientCount">0 clientes</div></div>' +
          '<button class="logout-btn" id="logoutBtn">Cerrar sesión</button>' +
        '</div>' +
        '<div class="searchbar">' +
          '<svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="11" cy="11" r="7"/><line x1="21" y1="21" x2="16.65" y2="16.65"/></svg>' +
          '<input type="text" id="searchInput" placeholder="Buscar por nombre, teléfono o patente" autocomplete="off">' +
        '</div>' +
      '</header>' +
      '<main id="main"></main>' +
      '<button class="fab" id="fabBtn" aria-label="Agregar cliente">+</button>';

    document.getElementById('logoutBtn').addEventListener('click', function(){
      sb.auth.signOut().then(function(){ location.reload(); });
    });
    document.getElementById('fabBtn').addEventListener('click', function(){ openClienteForm(null); });
    document.getElementById('searchInput').addEventListener('input', function(e){ view.search = e.target.value; render(); });
  }

  function boot(){
    renderShell();
    document.getElementById('main').innerHTML = '<div class="spinner">Cargando datos…</div>';
    Promise.all([
      sb.from('clientes').select('*'),
      sb.from('autos').select('*'),
      sb.from('reparaciones').select('*')
    ]).then(function(results){
      var errs = results.filter(function(r){ return r.error; });
      if(errs.length){ showError(errs[0].error); }
      data.clientes = results[0].data || [];
      data.autos = results[1].data || [];
      data.reparaciones = results[2].data || [];
      render();
    }).catch(showError);
  }

  sb.auth.getSession().then(function(res){
    session = res.data.session;
    if(session) boot(); else renderLogin();
  });

  // ---------- RENDER ----------
  function render(){
    var main = document.getElementById('main');
    if(!main) return;
    document.getElementById('clientCount').textContent = data.clientes.length + (data.clientes.length === 1 ? ' cliente' : ' clientes');
    if(view.screen === 'detail' && view.clienteId) renderDetail(main);
    else renderList(main);
  }

  function renderList(main){
    var search = view.search.trim().toLowerCase();
    var clientes = data.clientes.slice().sort(function(a,b){ return (a.nombre||'').localeCompare(b.nombre||'', 'es'); });
    if(search){
      clientes = clientes.filter(function(c){
        if((c.nombre||'').toLowerCase().indexOf(search) !== -1) return true;
        if((c.telefono||'').toLowerCase().indexOf(search) !== -1) return true;
        return autosDeCliente(c.id).some(function(a){
          return (a.patente||'').toLowerCase().indexOf(search) !== -1 ||
                 (a.marca||'').toLowerCase().indexOf(search) !== -1 ||
                 (a.modelo||'').toLowerCase().indexOf(search) !== -1;
        });
      });
    }
    if(data.clientes.length === 0){
      main.innerHTML = '<div class="empty"><div class="big">🔧</div><h3>Todavía no hay clientes</h3><p>Tocá el botón + para cargar el primero.</p></div>';
      return;
    }
    if(clientes.length === 0){
      main.innerHTML = '<div class="empty"><h3>Sin resultados</h3><p>Probá con otro nombre, teléfono o patente.</p></div>';
      return;
    }
    var html = '';
    clientes.forEach(function(c){
      var autos = autosDeCliente(c.id);
      var totalReparaciones = autos.reduce(function(sum, a){ return sum + reparacionesDeAuto(a.id).length; }, 0);
      html += '<div class="client-card" data-id="' + c.id + '">' +
        '<div class="client-top"><div><div class="client-name">' + esc(c.nombre) + '</div>' +
        (c.telefono ? '<div class="client-phone">' + esc(c.telefono) + '</div>' : '') + '</div>' +
        '<svg class="chevron" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polyline points="9 18 15 12 9 6"/></svg></div>' +
        '<div class="client-meta"><span class="badge">' + (autos.length || 0) + ' ' + (autos.length === 1 ? 'auto' : 'autos') + '</span>' +
        '<span class="badge">' + totalReparaciones + ' ' + (totalReparaciones === 1 ? 'reparación' : 'reparaciones') + '</span></div></div>';
    });
    main.innerHTML = html;
    main.querySelectorAll('.client-card').forEach(function(el){
      el.addEventListener('click', function(){
        view.screen = 'detail'; view.clienteId = el.getAttribute('data-id'); render(); window.scrollTo(0,0);
      });
    });
  }

  function renderDetail(main){
    var cliente = data.clientes.find(function(c){ return c.id === view.clienteId; });
    if(!cliente){ view.screen = 'list'; render(); return; }
    var autos = autosDeCliente(cliente.id);
    var html = '<button class="backbtn" id="btnBack"><svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polyline points="15 18 9 12 15 6"/></svg>Clientes</button>';
    html += '<div class="detail-header"><div class="detail-name">' + esc(cliente.nombre) + '</div>' +
      (cliente.telefono ? '<div class="detail-row"><a href="tel:' + esc(cliente.telefono) + '">' + esc(cliente.telefono) + '</a></div>' : '') +
      (cliente.notas ? '<div class="detail-row">' + esc(cliente.notas) + '</div>' : '') +
      '<div class="detail-actions"><button class="plain" id="btnEditCliente">Editar</button><button class="plain danger" id="btnDelCliente">Eliminar</button></div></div>';
    html += '<div class="section-head"><h2>Vehículos</h2><button class="plain accent" id="btnAddAuto">+ Auto</button></div>';
    if(autos.length === 0){
      html += '<div class="empty" style="padding:30px 10px;"><p>Este cliente todavía no tiene autos cargados.</p></div>';
    } else {
      autos.forEach(function(a){
        var reps = reparacionesDeAuto(a.id);
        html += '<div class="car-card" data-id="' + a.id + '"><div class="car-top"><div>' +
          '<div class="car-title">' + esc(a.marca) + ' ' + esc(a.modelo) + (a.anio ? ' · ' + esc(a.anio) : '') + '</div>' +
          (a.patente ? '<div class="car-sub" style="margin-top:6px;"><span class="plate">' + esc(a.patente.toUpperCase()) + '</span></div>' : '') +
          '</div><svg class="chevron" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polyline points="9 18 15 12 9 6"/></svg></div>' +
          '<div class="car-sub" style="margin-top:8px;">' + reps.length + (reps.length === 1 ? ' reparación registrada' : ' reparaciones registradas') + '</div></div>';
      });
    }
    main.innerHTML = html;
    document.getElementById('btnBack').addEventListener('click', function(){ view.screen = 'list'; render(); });
    document.getElementById('btnAddAuto').addEventListener('click', function(){ openAutoForm(cliente.id); });
    document.getElementById('btnEditCliente').addEventListener('click', function(){ openClienteForm(cliente); });
    document.getElementById('btnDelCliente').addEventListener('click', function(){
      if(!confirm('¿Eliminar a ' + cliente.nombre + ' junto con sus autos y reparaciones? Esta acción no se puede deshacer.')) return;
      sb.from('clientes').delete().eq('id', cliente.id).then(function(res){
        if(res.error) return showError(res.error);
        var autoIds = autosDeCliente(cliente.id).map(function(a){ return a.id; });
        data.reparaciones = data.reparaciones.filter(function(r){ return autoIds.indexOf(r.auto_id) === -1; });
        data.autos = data.autos.filter(function(a){ return a.cliente_id !== cliente.id; });
        data.clientes = data.clientes.filter(function(c){ return c.id !== cliente.id; });
        view.screen = 'list'; render();
      });
    });
    main.querySelectorAll('.car-card').forEach(function(el){
      el.addEventListener('click', function(){ openAutoDetail(el.getAttribute('data-id')); });
    });
  }

  function openAutoDetail(autoId){
    var auto = data.autos.find(function(a){ return a.id === autoId; });
    if(!auto) return;
    var cliente = data.clientes.find(function(c){ return c.id === auto.cliente_id; });
    var reps = reparacionesDeAuto(auto.id);
    var html = '<div class="sheet" style="max-width:560px;">' +
      '<div style="display:flex;justify-content:space-between;align-items:flex-start;gap:10px;margin-bottom:4px;">' +
      '<div><h3 style="margin-bottom:2px;">' + esc(auto.marca) + ' ' + esc(auto.modelo) + '</h3>' +
      '<div style="font-size:13px;color:var(--ink-soft);">' + esc(cliente ? cliente.nombre : '') + (auto.anio ? ' · ' + esc(auto.anio) : '') + '</div></div>' +
      (auto.patente ? '<span class="plate">' + esc(auto.patente.toUpperCase()) + '</span>' : '') + '</div>' +
      '<div style="display:flex;gap:8px;margin:14px 0 18px;"><button class="plain" id="btnEditAuto">Editar auto</button><button class="plain danger" id="btnDelAuto">Eliminar auto</button></div>' +
      '<div class="section-head" style="margin-top:0;"><h2>Historial de reparaciones</h2><button class="plain accent" id="btnAddRep">+ Reparación</button></div>' +
      '<div id="repList">' + (reps.length === 0 ? '<div class="empty" style="padding:24px 10px;"><p>Sin reparaciones cargadas todavía.</p></div>' :
        reps.map(function(r){
          return '<div class="repair-item"><div class="repair-date">' + fmtDate(r.fecha) + '</div>' +
            '<div class="repair-desc">' + esc(r.descripcion) + '</div>' +
            '<div class="repair-foot">' + (r.costo !== '' && r.costo !== null ? '<span>' + fmtMoney(r.costo) + '</span>' : '') +
            (r.km ? '<span>' + Number(r.km).toLocaleString('es-AR') + ' km</span>' : '') + '</div>' +
            '<div class="repair-actions"><button class="link-btn" data-edit-rep="' + r.id + '">Editar</button> · ' +
            '<button class="link-btn danger" data-del-rep="' + r.id + '">Eliminar</button></div></div>';
        }).join('')) + '</div>' +
      '<div class="sheet-actions" style="margin-top:18px;"><button class="plain" id="btnCloseAutoSheet">Cerrar</button></div></div>';

    var overlay = document.createElement('div');
    overlay.className = 'overlay';
    overlay.innerHTML = html;
    document.getElementById('modalRoot').appendChild(overlay);
    function close(){ overlay.remove(); }
    overlay.addEventListener('click', function(e){ if(e.target === overlay) close(); });
    overlay.querySelector('#btnCloseAutoSheet').addEventListener('click', close);
    overlay.querySelector('#btnAddRep').addEventListener('click', function(){ openRepairForm(auto.id, null, function(){ close(); openAutoDetail(auto.id); }); });
    overlay.querySelector('#btnEditAuto').addEventListener('click', function(){ close(); openAutoForm(auto.cliente_id, auto); });
    overlay.querySelector('#btnDelAuto').addEventListener('click', function(){
      if(!confirm('¿Eliminar este auto y todas sus reparaciones registradas?')) return;
      sb.from('autos').delete().eq('id', auto.id).then(function(res){
        if(res.error) return showError(res.error);
        data.reparaciones = data.reparaciones.filter(function(r){ return r.auto_id !== auto.id; });
        data.autos = data.autos.filter(function(a){ return a.id !== auto.id; });
        close(); render();
      });
    });
    overlay.querySelectorAll('[data-edit-rep]').forEach(function(btn){
      btn.addEventListener('click', function(){
        var rep = data.reparaciones.find(function(r){ return r.id === btn.getAttribute('data-edit-rep'); });
        close(); openRepairForm(auto.id, rep, function(){ openAutoDetail(auto.id); });
      });
    });
    overlay.querySelectorAll('[data-del-rep]').forEach(function(btn){
      btn.addEventListener('click', function(){
        if(!confirm('¿Eliminar esta reparación del historial?')) return;
        sb.from('reparaciones').delete().eq('id', btn.getAttribute('data-del-rep')).then(function(res){
          if(res.error) return showError(res.error);
          data.reparaciones = data.reparaciones.filter(function(r){ return r.id !== btn.getAttribute('data-del-rep'); });
          close(); openAutoDetail(auto.id);
        });
      });
    });
  }

  function openModal(innerHtml, onMount){
    var overlay = document.createElement('div');
    overlay.className = 'overlay';
    overlay.innerHTML = '<div class="sheet">' + innerHtml + '</div>';
    document.getElementById('modalRoot').appendChild(overlay);
    function close(){ overlay.remove(); }
    overlay.addEventListener('click', function(e){ if(e.target === overlay) close(); });
    onMount(overlay, close);
    return { overlay: overlay, close: close };
  }

  function openClienteForm(existing){
    var isEdit = !!existing;
    var html = '<h3>' + (isEdit ? 'Editar cliente' : 'Nuevo cliente') + '</h3>' +
      '<div class="field"><label for="fNombre">Nombre</label><input id="fNombre" type="text" value="' + (isEdit ? esc(existing.nombre) : '') + '" placeholder="Nombre y apellido"><div class="err" id="errNombre">Ingresá un nombre.</div></div>' +
      '<div class="field"><label for="fTelefono">Teléfono</label><input id="fTelefono" type="tel" value="' + (isEdit ? esc(existing.telefono) : '') + '" placeholder="11 5555 5555"></div>' +
      '<div class="field"><label for="fNotas">Notas (opcional)</label><textarea id="fNotas" placeholder="Dirección, referencia, etc.">' + (isEdit ? esc(existing.notas) : '') + '</textarea></div>' +
      '<div class="sheet-actions"><button class="plain" id="btnCancel">Cancelar</button><button class="plain accent" id="btnSave">' + (isEdit ? 'Guardar cambios' : 'Agregar cliente') + '</button></div>';
    openModal(html, function(overlay, close){
      overlay.querySelector('#fNombre').focus();
      overlay.querySelector('#btnCancel').addEventListener('click', close);
      overlay.querySelector('#btnSave').addEventListener('click', function(){
        var nombre = overlay.querySelector('#fNombre').value.trim();
        var telefono = overlay.querySelector('#fTelefono').value.trim();
        var notas = overlay.querySelector('#fNotas').value.trim();
        if(!nombre){ overlay.querySelector('#errNombre').className = 'err show'; return; }
        var btn = overlay.querySelector('#btnSave'); btn.disabled = true;
        if(isEdit){
          sb.from('clientes').update({ nombre: nombre, telefono: telefono, notas: notas }).eq('id', existing.id).then(function(res){
            if(res.error){ btn.disabled = false; return showError(res.error); }
            existing.nombre = nombre; existing.telefono = telefono; existing.notas = notas;
            close(); render();
          });
        } else {
          sb.from('clientes').insert({ nombre: nombre, telefono: telefono, notas: notas }).select().then(function(res){
            if(res.error){ btn.disabled = false; return showError(res.error); }
            data.clientes.push(res.data[0]);
            close(); render();
          });
        }
      });
      overlay.querySelector('#fNombre').addEventListener('input', function(){ overlay.querySelector('#errNombre').className = 'err'; });
    });
  }

  function openAutoForm(clienteId, existing){
    var isEdit = !!existing;
    var html = '<h3>' + (isEdit ? 'Editar auto' : 'Nuevo auto') + '</h3>' +
      '<div class="field-row"><div class="field"><label for="fMarca">Marca</label><input id="fMarca" type="text" value="' + (isEdit ? esc(existing.marca) : '') + '" placeholder="Ford"></div>' +
      '<div class="field"><label for="fModelo">Modelo</label><input id="fModelo" type="text" value="' + (isEdit ? esc(existing.modelo) : '') + '" placeholder="Fiesta"></div></div>' +
      '<div class="field-row"><div class="field"><label for="fAnio">Año</label><input id="fAnio" type="number" inputmode="numeric" value="' + (isEdit && existing.anio ? esc(existing.anio) : '') + '" placeholder="2018"></div>' +
      '<div class="field"><label for="fPatente">Patente</label><input id="fPatente" type="text" value="' + (isEdit ? esc(existing.patente) : '') + '" placeholder="AB123CD" style="text-transform:uppercase;"></div></div>' +
      '<div class="err" id="errAuto">Cargá al menos la marca o el modelo.</div>' +
      '<div class="sheet-actions"><button class="plain" id="btnCancel">Cancelar</button><button class="plain accent" id="btnSave">' + (isEdit ? 'Guardar cambios' : 'Agregar auto') + '</button></div>';
    openModal(html, function(overlay, close){
      overlay.querySelector('#fMarca').focus();
      overlay.querySelector('#btnCancel').addEventListener('click', close);
      overlay.querySelector('#btnSave').addEventListener('click', function(){
        var marca = overlay.querySelector('#fMarca').value.trim();
        var modelo = overlay.querySelector('#fModelo').value.trim();
        var anio = overlay.querySelector('#fAnio').value.trim();
        var patente = overlay.querySelector('#fPatente').value.trim();
        if(!marca && !modelo){ overlay.querySelector('#errAuto').className = 'err show'; return; }
        var btn = overlay.querySelector('#btnSave'); btn.disabled = true;
        if(isEdit){
          sb.from('autos').update({ marca: marca, modelo: modelo, anio: anio, patente: patente }).eq('id', existing.id).then(function(res){
            if(res.error){ btn.disabled = false; return showError(res.error); }
            existing.marca = marca; existing.modelo = modelo; existing.anio = anio; existing.patente = patente;
            close(); render();
          });
        } else {
          sb.from('autos').insert({ cliente_id: clienteId, marca: marca, modelo: modelo, anio: anio, patente: patente }).select().then(function(res){
            if(res.error){ btn.disabled = false; return showError(res.error); }
            data.autos.push(res.data[0]);
            close(); render();
          });
        }
      });
    });
  }

  function openRepairForm(autoId, existing, onDone){
    var isEdit = !!existing;
    var html = '<h3>' + (isEdit ? 'Editar reparación' : 'Nueva reparación') + '</h3>' +
      '<div class="field-row"><div class="field"><label for="fFecha">Fecha</label><input id="fFecha" type="date" value="' + (isEdit ? esc(existing.fecha) : todayISO()) + '"></div>' +
      '<div class="field"><label for="fKm">Kilometraje</label><input id="fKm" type="number" inputmode="numeric" value="' + (isEdit && existing.km ? esc(existing.km) : '') + '" placeholder="85000"></div></div>' +
      '<div class="field"><label for="fDescripcion">Trabajo realizado</label><textarea id="fDescripcion" placeholder="Cambio de correa de distribución, bujías...">' + (isEdit ? esc(existing.descripcion) : '') + '</textarea><div class="err" id="errDesc">Describí el trabajo realizado.</div></div>' +
      '<div class="field"><label for="fCosto">Costo</label><input id="fCosto" type="number" inputmode="decimal" value="' + (isEdit && existing.costo !== undefined && existing.costo !== null ? esc(existing.costo) : '') + '" placeholder="45000"></div>' +
      '<div class="sheet-actions"><button class="plain" id="btnCancel">Cancelar</button><button class="plain accent" id="btnSave">' + (isEdit ? 'Guardar cambios' : 'Agregar reparación') + '</button></div>';
    openModal(html, function(overlay, close){
      overlay.querySelector('#fFecha').focus();
      overlay.querySelector('#btnCancel').addEventListener('click', function(){ close(); if(onDone) onDone(); });
      overlay.querySelector('#btnSave').addEventListener('click', function(){
        var fecha = overlay.querySelector('#fFecha').value;
        var descripcion = overlay.querySelector('#fDescripcion').value.trim();
        var costo = overlay.querySelector('#fCosto').value;
        var km = overlay.querySelector('#fKm').value;
        if(!descripcion){ overlay.querySelector('#errDesc').className = 'err show'; return; }
        var btn = overlay.querySelector('#btnSave'); btn.disabled = true;
        var payload = { fecha: fecha, descripcion: descripcion, costo: costo === '' ? null : Number(costo), km: km === '' ? null : Number(km) };
        if(isEdit){
          sb.from('reparaciones').update(payload).eq('id', existing.id).then(function(res){
            if(res.error){ btn.disabled = false; return showError(res.error); }
            Object.assign(existing, payload);
            close(); if(onDone) onDone();
          });
        } else {
          payload.auto_id = autoId;
          sb.from('reparaciones').insert(payload).select().then(function(res){
            if(res.error){ btn.disabled = false; return showError(res.error); }
            data.reparaciones.push(res.data[0]);
            close(); if(onDone) onDone();
          });
        }
      });
      overlay.querySelector('#fDescripcion').addEventListener('input', function(){ overlay.querySelector('#errDesc').className = 'err'; });
    });
  }
})();
</script>
</body>
</html>
