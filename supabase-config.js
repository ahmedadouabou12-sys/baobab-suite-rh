// Configuration publique du projet Supabase. Remplacez les deux valeurs ci-dessous.
// La clé anon/publishable peut être utilisée côté navigateur UNIQUEMENT avec RLS activé.
// NE JAMAIS coller ici la clé service_role ou une clé secrète.
window.BAOBA_SUPABASE_URL = 'https://htgimboeaxjcpsoocvrb.supabase.co';
window.BAOBA_SUPABASE_ANON_KEY = sb_publishable_27KQJDs5W7fbkL912-Gfgg_2D65CzMf
if (window.supabase && window.BAOBA_SUPABASE_URL.startsWith('https://') && window.BAOBA_SUPABASE_ANON_KEY && !window.BAOBA_SUPABASE_ANON_KEY.includes('sb_publishable_27KQJDs5W7fbkL912-Gfgg_2D65CzMf')) {
  window.baobabSupabase = window.supabase.createClient(window.BAOBA_SUPABASE_URL, window.BAOBA_SUPABASE_ANON_KEY, { auth: { persistSession: true, autoRefreshToken: true, detectSessionInUrl: true } });
}
