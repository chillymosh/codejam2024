CREATE TABLE IF NOT EXISTS teams_members (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    team_id UUID references teams(id) ON DELETE CASCADE,
    user_id UUID references users(id) ON DELETE CASCADE,
    role TEXT NOT NULL,
    created_on TIMESTAMP WITH TIME ZONE DEFAULT (now() AT TIME ZONE('utc'))
);