-- Active: 1710959389378@@127.0.0.1@5432@codejam2024
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE IF NOT EXISTS users (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    service_name TEXT NOT NULL,
    service_user_id TEXT NOT NULL,
    display_name TEXT NOT NULL DEFAULT '',
    created_on TIMESTAMP WITH TIME ZONE DEFAULT (now() AT TIME ZONE('utc'))
);

CREATE UNIQUE INDEX IF NOT EXISTS idx_service_user ON users (service_name, service_user_id);
    
CREATE TABLE IF NOT EXISTS teams (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    event_id UUID references events(id),
    owner_user_id UUID references users(id) ON DELETE NO ACTION ON UPDATE NO ACTION,
    name TEXT NOT NULL,
    visibility TEXT,
    timezone TEXT,
    technologies TEXT,
    availability TEXT NOT NULL,
    description TEXT NOT NULL,
    created_on TIMESTAMP WITH TIME ZONE DEFAULT (now() AT TIME ZONE('utc'))
);

CREATE TABLE IF NOT EXISTS team_users (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    created_on TIMESTAMP WITH TIME ZONE DEFAULT (now() AT TIME ZONE('utc'))
    team_id UUID references teams(id) ON DELETE CASCADE ON UPDATE NO ACTION
    user_id UUID reference users(id) ON DELETE CASCADE ON UPDATE NO ACTION
);

CREATE TABLE IF NOT EXISTS events (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    status_id integer,
    title TEXT NOT NULL,
    description TEXT NOT NULL,
    timeline TEXT NOT NULL,
    rules TEXT NOT NULL,
    organizer_user_id UUID NOT NULL,
    max_teams integer default -1,
    starts_at TIMESTAMP WITH TIME ZONE,
    ends_at TIMESTAMP WITH TIME ZONE,
    created_on TIMESTAMP WITH TIME ZONE DEFAULT (now() AT TIME ZONE('utc'))
);

CREATE TABLE IF NOT EXISTS statuses (
    id SERIAL PRIMARY KEY,
    code TEXT NOT NULL UNIQUE,
    title TEXT NOT NULL,
    description TEXT NOT NULL
);

INSERT INTO statuses (id, code, title, description) VALUES (1, 'PLANNING', 'Planning', 'Event is not yet live.  The organizer may edit and preview the site but normal users will just see a placeholder page')
ON CONFLICT (id) DO UPDATE set code = EXCLUDED.code, title = EXCLUDED.title, description = EXCLUDED.description;

INSERT INTO statuses (id, code, title, description) VALUES (2, 'PUBLISHED', 'Published', 'Event is publicly visible.')
ON CONFLICT (id) DO UPDATE set code = EXCLUDED.code, title = EXCLUDED.title, description = EXCLUDED.description;

INSERT INTO statuses (id, code, title, description) VALUES (3, 'STARTED', 'Started', 'The theme will be shown publicly and users can start coding. Submissions will be accepted during this time.')
ON CONFLICT (id) DO UPDATE set code = EXCLUDED.code, title = EXCLUDED.title, description = EXCLUDED.description;

INSERT INTO statuses (id, code, title, description) VALUES (4, 'VOTING', 'Voting Open', 'Submissions are closed and voting is underway')
ON CONFLICT (id) DO UPDATE set code = EXCLUDED.code, title = EXCLUDED.title, description = EXCLUDED.description;

INSERT INTO statuses (id, code, title, description) VALUES (5, 'ENDED', 'Ended', 'Competition is over.  Results may still be viewed, but no more voting is allowed')
ON CONFLICT (id) DO UPDATE set code = EXCLUDED.code, title = EXCLUDED.title, description = EXCLUDED.description;



