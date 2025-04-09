-- Enable UUID support if not already
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE TABLE messages (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID REFERENCES auth.users,
  name TEXT NOT NULL,
  email TEXT NOT NULL,
  message TEXT NOT NULL,
  created_at TIMESTAMPTZ DEFAULT NOW()
);
ALTER TABLE messages ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Users can insert their messages"
ON messages
FOR INSERT
WITH CHECK (auth.uid() = user_id);
CREATE POLICY "Users can view their messages"
ON messages
FOR SELECT
USING (auth.uid() = user_id);