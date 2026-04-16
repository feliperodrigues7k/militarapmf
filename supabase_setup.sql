-- ============================================================
-- SETUP DO BANCO - GERÊNCIA TI APMF / CPMGAS
-- Execute este script no Supabase SQL Editor:
-- https://supabase.com/dashboard/project/rohwralirtujspvtuogz/sql/new
-- ============================================================

-- 1. Criar tabela principal (armazena todos os dados como JSON)
CREATE TABLE IF NOT EXISTS ti_data (
  id          INTEGER PRIMARY KEY,
  data        JSONB NOT NULL DEFAULT '{}',
  updated_at  TIMESTAMPTZ DEFAULT NOW()
);

-- 2. Habilitar RLS (Row Level Security)
ALTER TABLE ti_data ENABLE ROW LEVEL SECURITY;

-- 3. Permitir acesso total via chave anon (ferramenta interna)
DROP POLICY IF EXISTS "anon_all" ON ti_data;
CREATE POLICY "anon_all" ON ti_data
  FOR ALL TO anon
  USING (true)
  WITH CHECK (true);

-- 4. Inserir linha inicial vazia (id = 1)
INSERT INTO ti_data (id, data)
VALUES (1, '{}')
ON CONFLICT (id) DO NOTHING;

-- Pronto! Tabela criada com sucesso.
