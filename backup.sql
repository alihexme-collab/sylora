--
-- PostgreSQL database dump
--

\restrict VBp4MP2UHmlxVwpAWDCa3Zpbgea8m5MJPvA3I5guT7wQhNXQwbz1OKsDxNrplaS

-- Dumped from database version 18.4 (Debian 18.4-1.pgdg13+1)
-- Dumped by pg_dump version 18.4 (Ubuntu 18.4-1.pgdg24.04+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

ALTER TABLE IF EXISTS ONLY public.world_rules DROP CONSTRAINT IF EXISTS world_rules_affected_location_id_fkey;
ALTER TABLE IF EXISTS ONLY public.world_rules DROP CONSTRAINT IF EXISTS world_rules_affected_civilization_id_fkey;
ALTER TABLE IF EXISTS ONLY public.world_objects DROP CONSTRAINT IF EXISTS world_objects_location_id_fkey;
ALTER TABLE IF EXISTS ONLY public.world_links DROP CONSTRAINT IF EXISTS world_links_target_location_id_fkey;
ALTER TABLE IF EXISTS ONLY public.world_links DROP CONSTRAINT IF EXISTS world_links_source_location_id_fkey;
ALTER TABLE IF EXISTS ONLY public.npc_merchant_stock DROP CONSTRAINT IF EXISTS stock_npc_fkey;
ALTER TABLE IF EXISTS ONLY public.npc_merchant_stock DROP CONSTRAINT IF EXISTS stock_item_fkey;
ALTER TABLE IF EXISTS ONLY public.skill_discovery_rule DROP CONSTRAINT IF EXISTS skill_discovery_rule_skill_id_fkey;
ALTER TABLE IF EXISTS ONLY public.npc_interaction_rule DROP CONSTRAINT IF EXISTS rule_npc_fkey;
ALTER TABLE IF EXISTS ONLY public.race DROP CONSTRAINT IF EXISTS race_civilization_id_fkey;
ALTER TABLE IF EXISTS ONLY public.quest DROP CONSTRAINT IF EXISTS quest_location_id_fkey;
ALTER TABLE IF EXISTS ONLY public.quest DROP CONSTRAINT IF EXISTS quest_difficulty_rank_fkey;
ALTER TABLE IF EXISTS ONLY public.player_wallet DROP CONSTRAINT IF EXISTS player_wallet_player_id_fkey;
ALTER TABLE IF EXISTS ONLY public.character_stats DROP CONSTRAINT IF EXISTS player_stats_charecter_id_fkey;
ALTER TABLE IF EXISTS ONLY public.player_state DROP CONSTRAINT IF EXISTS player_state_player_id_fkey;
ALTER TABLE IF EXISTS ONLY public.player_session DROP CONSTRAINT IF EXISTS player_session_player_id_fkey;
ALTER TABLE IF EXISTS ONLY public.party_member DROP CONSTRAINT IF EXISTS party_member_party_id_fkey;
ALTER TABLE IF EXISTS ONLY public.party_member DROP CONSTRAINT IF EXISTS party_member_character_id_fkey;
ALTER TABLE IF EXISTS ONLY public.party DROP CONSTRAINT IF EXISTS party_leader_character_id_fkey;
ALTER TABLE IF EXISTS ONLY public.npc DROP CONSTRAINT IF EXISTS npc_location_fkey;
ALTER TABLE IF EXISTS ONLY public.notification DROP CONSTRAINT IF EXISTS notification_player_id_fkey;
ALTER TABLE IF EXISTS ONLY public.notification DROP CONSTRAINT IF EXISTS notification_character_id_fkey;
ALTER TABLE IF EXISTS ONLY public.message DROP CONSTRAINT IF EXISTS message_sender_player_id_fkey;
ALTER TABLE IF EXISTS ONLY public.message DROP CONSTRAINT IF EXISTS message_sender_character_id_fkey;
ALTER TABLE IF EXISTS ONLY public.message DROP CONSTRAINT IF EXISTS message_receiver_player_id_fkey;
ALTER TABLE IF EXISTS ONLY public.message DROP CONSTRAINT IF EXISTS message_receiver_character_id_fkey;
ALTER TABLE IF EXISTS ONLY public.market_listing DROP CONSTRAINT IF EXISTS market_seller_fkey;
ALTER TABLE IF EXISTS ONLY public.player_mail DROP CONSTRAINT IF EXISTS mail_receiver_fkey;
ALTER TABLE IF EXISTS ONLY public.login_history DROP CONSTRAINT IF EXISTS login_history_session_id_fkey;
ALTER TABLE IF EXISTS ONLY public.login_history DROP CONSTRAINT IF EXISTS login_history_player_id_fkey;
ALTER TABLE IF EXISTS ONLY public.location_feature DROP CONSTRAINT IF EXISTS location_feature_location_id_fkey;
ALTER TABLE IF EXISTS ONLY public.inventory DROP CONSTRAINT IF EXISTS inventory_item_id_fkey;
ALTER TABLE IF EXISTS ONLY public.inventory DROP CONSTRAINT IF EXISTS inventory_character_id_fkey;
ALTER TABLE IF EXISTS ONLY public.guild_member DROP CONSTRAINT IF EXISTS guild_member_guild_id_fkey;
ALTER TABLE IF EXISTS ONLY public.guild_member DROP CONSTRAINT IF EXISTS guild_member_character_id_fkey;
ALTER TABLE IF EXISTS ONLY public.guild DROP CONSTRAINT IF EXISTS guild_leader_character_id_fkey;
ALTER TABLE IF EXISTS ONLY public.world_links DROP CONSTRAINT IF EXISTS fk_world_links_required_item;
ALTER TABLE IF EXISTS ONLY public.character_stats DROP CONSTRAINT IF EXISTS fk_player_stats_character;
ALTER TABLE IF EXISTS ONLY public.civilizations DROP CONSTRAINT IF EXISTS fk_civilizations_starting_location;
ALTER TABLE IF EXISTS ONLY public.event_history DROP CONSTRAINT IF EXISTS event_history_player_id_fkey;
ALTER TABLE IF EXISTS ONLY public.equipment DROP CONSTRAINT IF EXISTS equipment_item_id_fkey;
ALTER TABLE IF EXISTS ONLY public.equipment DROP CONSTRAINT IF EXISTS equipment_character_id_fkey;
ALTER TABLE IF EXISTS ONLY public.enemy_stats DROP CONSTRAINT IF EXISTS enemy_stats_enemy_id_fkey;
ALTER TABLE IF EXISTS ONLY public.enemy DROP CONSTRAINT IF EXISTS enemy_rank_id_fkey;
ALTER TABLE IF EXISTS ONLY public.enemy DROP CONSTRAINT IF EXISTS enemy_location_id_fkey;
ALTER TABLE IF EXISTS ONLY public.enemy_instance DROP CONSTRAINT IF EXISTS enemy_instance_location_id_fkey;
ALTER TABLE IF EXISTS ONLY public.enemy_instance DROP CONSTRAINT IF EXISTS "enemy_instance_enemy_id _fkey";
ALTER TABLE IF EXISTS ONLY public.economy_ledger DROP CONSTRAINT IF EXISTS economy_ledger_wallet_id_fkey;
ALTER TABLE IF EXISTS ONLY public.economy_ledger DROP CONSTRAINT IF EXISTS economy_ledger_player_id_fkey;
ALTER TABLE IF EXISTS ONLY public.dungeon_item_config DROP CONSTRAINT IF EXISTS dungeon_item_config_item_id_fkey;
ALTER TABLE IF EXISTS ONLY public.dungeon_item_config DROP CONSTRAINT IF EXISTS dungeon_item_config_dungeon_id_fkey;
ALTER TABLE IF EXISTS ONLY public.dungeon_enemy_config DROP CONSTRAINT IF EXISTS dungeon_enemy_config_enemy_id_fkey;
ALTER TABLE IF EXISTS ONLY public.dungeon_enemy_config DROP CONSTRAINT IF EXISTS dungeon_enemy_config_dungeon_id_fkey;
ALTER TABLE IF EXISTS ONLY public.cooldowns DROP CONSTRAINT IF EXISTS cooldowns_skill_id_fkey;
ALTER TABLE IF EXISTS ONLY public.cooldowns DROP CONSTRAINT IF EXISTS cooldowns_character_id_fkey;
ALTER TABLE IF EXISTS ONLY public.clan_member DROP CONSTRAINT IF EXISTS clan_member_clan_id_fkey;
ALTER TABLE IF EXISTS ONLY public.clan_member DROP CONSTRAINT IF EXISTS clan_member_character_id_fkey;
ALTER TABLE IF EXISTS ONLY public.clan DROP CONSTRAINT IF EXISTS clan_leader_character_id_fkey;
ALTER TABLE IF EXISTS ONLY public.character_skill DROP CONSTRAINT IF EXISTS character_skill_skill_id_fkey;
ALTER TABLE IF EXISTS ONLY public.character_skill DROP CONSTRAINT IF EXISTS character_skill_character_id_fkey;
ALTER TABLE IF EXISTS ONLY public."character" DROP CONSTRAINT IF EXISTS character_rank_id_fkey;
ALTER TABLE IF EXISTS ONLY public.character_quest DROP CONSTRAINT IF EXISTS character_quest_quest_id_fkey;
ALTER TABLE IF EXISTS ONLY public.character_quest DROP CONSTRAINT IF EXISTS character_quest_character_id_fkey;
ALTER TABLE IF EXISTS ONLY public."character" DROP CONSTRAINT IF EXISTS character_player_id_fkey;
ALTER TABLE IF EXISTS ONLY public.character_achievement DROP CONSTRAINT IF EXISTS character_achievement_character_id_fkey;
ALTER TABLE IF EXISTS ONLY public.character_achievement DROP CONSTRAINT IF EXISTS character_achievement_achievement_id_fkey;
ALTER TABLE IF EXISTS ONLY public.battle_log DROP CONSTRAINT IF EXISTS battle_log_enemy_id_fkey;
ALTER TABLE IF EXISTS ONLY public.battle_log DROP CONSTRAINT IF EXISTS battle_log_character_id_fkey;
ALTER TABLE IF EXISTS ONLY public.world_rules DROP CONSTRAINT IF EXISTS world_rules_rule_key_key;
ALTER TABLE IF EXISTS ONLY public.world_rules DROP CONSTRAINT IF EXISTS world_rules_pkey;
ALTER TABLE IF EXISTS ONLY public.world_objects DROP CONSTRAINT IF EXISTS world_objects_pkey;
ALTER TABLE IF EXISTS ONLY public.world_links DROP CONSTRAINT IF EXISTS world_links_pkey;
ALTER TABLE IF EXISTS ONLY public.world_events DROP CONSTRAINT IF EXISTS world_events_pkey;
ALTER TABLE IF EXISTS ONLY public.world_environment DROP CONSTRAINT IF EXISTS world_environment_pkey;
ALTER TABLE IF EXISTS ONLY public.player DROP CONSTRAINT IF EXISTS users_pkey;
ALTER TABLE IF EXISTS ONLY public.skill DROP CONSTRAINT IF EXISTS skill_pkey;
ALTER TABLE IF EXISTS ONLY public.skill_discovery_rule DROP CONSTRAINT IF EXISTS skill_discovery_rule_pkey;
ALTER TABLE IF EXISTS ONLY public.rank DROP CONSTRAINT IF EXISTS rank_pkey;
ALTER TABLE IF EXISTS ONLY public.race DROP CONSTRAINT IF EXISTS race_pkey;
ALTER TABLE IF EXISTS ONLY public.quest DROP CONSTRAINT IF EXISTS quest_pkey;
ALTER TABLE IF EXISTS ONLY public.player_wallet DROP CONSTRAINT IF EXISTS player_wallet_player_id_key;
ALTER TABLE IF EXISTS ONLY public.player_wallet DROP CONSTRAINT IF EXISTS player_wallet_pkey;
ALTER TABLE IF EXISTS ONLY public.character_stats DROP CONSTRAINT IF EXISTS player_stats_pkey;
ALTER TABLE IF EXISTS ONLY public.player_session DROP CONSTRAINT IF EXISTS player_session_pkey;
ALTER TABLE IF EXISTS ONLY public.player_mail DROP CONSTRAINT IF EXISTS player_mail_pkey;
ALTER TABLE IF EXISTS ONLY public.party DROP CONSTRAINT IF EXISTS party_pkey;
ALTER TABLE IF EXISTS ONLY public.party_member DROP CONSTRAINT IF EXISTS party_member_pkey;
ALTER TABLE IF EXISTS ONLY public.npc_stats DROP CONSTRAINT IF EXISTS npc_stats_pkey;
ALTER TABLE IF EXISTS ONLY public.npc DROP CONSTRAINT IF EXISTS npc_pkey;
ALTER TABLE IF EXISTS ONLY public.npc_merchant_stock DROP CONSTRAINT IF EXISTS npc_merchant_stock_pkey;
ALTER TABLE IF EXISTS ONLY public.npc_interaction_rule DROP CONSTRAINT IF EXISTS npc_interaction_rule_pkey;
ALTER TABLE IF EXISTS ONLY public.notification DROP CONSTRAINT IF EXISTS notification_pkey;
ALTER TABLE IF EXISTS ONLY public.message DROP CONSTRAINT IF EXISTS message_pkey;
ALTER TABLE IF EXISTS ONLY public.market_listing DROP CONSTRAINT IF EXISTS market_listing_pkey;
ALTER TABLE IF EXISTS ONLY public.login_history DROP CONSTRAINT IF EXISTS login_history_pkey;
ALTER TABLE IF EXISTS ONLY public.location DROP CONSTRAINT IF EXISTS location_pkey;
ALTER TABLE IF EXISTS ONLY public.location_feature DROP CONSTRAINT IF EXISTS location_feature_pkey;
ALTER TABLE IF EXISTS ONLY public.item DROP CONSTRAINT IF EXISTS item_pkey;
ALTER TABLE IF EXISTS ONLY public.inventory DROP CONSTRAINT IF EXISTS inventory_pkey;
ALTER TABLE IF EXISTS ONLY public.guild DROP CONSTRAINT IF EXISTS guild_pkey;
ALTER TABLE IF EXISTS ONLY public.guild_member DROP CONSTRAINT IF EXISTS guild_member_pkey;
ALTER TABLE IF EXISTS ONLY public.family_background DROP CONSTRAINT IF EXISTS family_background_pkey;
ALTER TABLE IF EXISTS ONLY public.event_history DROP CONSTRAINT IF EXISTS event_history_pkey;
ALTER TABLE IF EXISTS ONLY public.equipment DROP CONSTRAINT IF EXISTS equipment_pkey;
ALTER TABLE IF EXISTS ONLY public.equipment DROP CONSTRAINT IF EXISTS equipment_item_id_key;
ALTER TABLE IF EXISTS ONLY public.enemy_stats DROP CONSTRAINT IF EXISTS enemy_stats_pkey;
ALTER TABLE IF EXISTS ONLY public.enemy DROP CONSTRAINT IF EXISTS enemy_pkey;
ALTER TABLE IF EXISTS ONLY public.enemy_instance DROP CONSTRAINT IF EXISTS enemy_instance_pkey;
ALTER TABLE IF EXISTS ONLY public.economy_ledger DROP CONSTRAINT IF EXISTS economy_ledger_pkey;
ALTER TABLE IF EXISTS ONLY public.dungeon DROP CONSTRAINT IF EXISTS dungeon_pkey;
ALTER TABLE IF EXISTS ONLY public.dungeon_item_config DROP CONSTRAINT IF EXISTS dungeon_item_config_pkey;
ALTER TABLE IF EXISTS ONLY public.dungeon_enemy_config DROP CONSTRAINT IF EXISTS dungeon_enemy_config_pkey;
ALTER TABLE IF EXISTS ONLY public.cooldowns DROP CONSTRAINT IF EXISTS cooldowns_pkey;
ALTER TABLE IF EXISTS ONLY public.clan DROP CONSTRAINT IF EXISTS clan_pkey;
ALTER TABLE IF EXISTS ONLY public.clan_member DROP CONSTRAINT IF EXISTS clan_member_pkey;
ALTER TABLE IF EXISTS ONLY public.civilizations DROP CONSTRAINT IF EXISTS civilizations_slug_key;
ALTER TABLE IF EXISTS ONLY public.civilizations DROP CONSTRAINT IF EXISTS civilizations_pkey;
ALTER TABLE IF EXISTS ONLY public.character_skill DROP CONSTRAINT IF EXISTS character_skill_pkey;
ALTER TABLE IF EXISTS ONLY public.character_quest DROP CONSTRAINT IF EXISTS character_quest_pkey;
ALTER TABLE IF EXISTS ONLY public."character" DROP CONSTRAINT IF EXISTS character_pkey;
ALTER TABLE IF EXISTS ONLY public.character_achievement DROP CONSTRAINT IF EXISTS character_achievement_pkey;
ALTER TABLE IF EXISTS ONLY public.battle_log DROP CONSTRAINT IF EXISTS battle_log_pkey;
ALTER TABLE IF EXISTS ONLY public.achievement DROP CONSTRAINT IF EXISTS achievement_pkey;
ALTER TABLE IF EXISTS ONLY public.achievement DROP CONSTRAINT IF EXISTS achievement_code_key;
ALTER TABLE IF EXISTS public.world_rules ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.world_objects ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.world_links ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.world_events ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.civilizations ALTER COLUMN id DROP DEFAULT;
DROP SEQUENCE IF EXISTS public.world_rules_id_seq;
DROP TABLE IF EXISTS public.world_rules;
DROP SEQUENCE IF EXISTS public.world_objects_id_seq;
DROP TABLE IF EXISTS public.world_objects;
DROP SEQUENCE IF EXISTS public.world_links_id_seq;
DROP TABLE IF EXISTS public.world_links;
DROP SEQUENCE IF EXISTS public.world_events_id_seq;
DROP TABLE IF EXISTS public.world_events;
DROP TABLE IF EXISTS public.world_environment;
DROP TABLE IF EXISTS public.skill_discovery_rule;
DROP TABLE IF EXISTS public.skill;
DROP TABLE IF EXISTS public.rank;
DROP TABLE IF EXISTS public.race;
DROP TABLE IF EXISTS public.quest;
DROP TABLE IF EXISTS public.player_wallet;
DROP TABLE IF EXISTS public.player_state;
DROP TABLE IF EXISTS public.player_session;
DROP TABLE IF EXISTS public.player_mail;
DROP TABLE IF EXISTS public.player;
DROP TABLE IF EXISTS public.party_member;
DROP TABLE IF EXISTS public.party;
DROP TABLE IF EXISTS public.npc_stats;
DROP TABLE IF EXISTS public.npc_merchant_stock;
DROP TABLE IF EXISTS public.npc_interaction_rule;
DROP TABLE IF EXISTS public.npc;
DROP TABLE IF EXISTS public.notification;
DROP TABLE IF EXISTS public.message;
DROP TABLE IF EXISTS public.market_listing;
DROP TABLE IF EXISTS public.login_history;
DROP TABLE IF EXISTS public.location_feature;
DROP TABLE IF EXISTS public.location;
DROP TABLE IF EXISTS public.item;
DROP TABLE IF EXISTS public.inventory;
DROP TABLE IF EXISTS public.guild_member;
DROP TABLE IF EXISTS public.guild;
DROP TABLE IF EXISTS public.family_background;
DROP TABLE IF EXISTS public.event_history;
DROP TABLE IF EXISTS public.equipment;
DROP TABLE IF EXISTS public.enemy_stats;
DROP TABLE IF EXISTS public.enemy_instance;
DROP TABLE IF EXISTS public.enemy;
DROP TABLE IF EXISTS public.economy_ledger;
DROP TABLE IF EXISTS public.dungeon_item_config;
DROP TABLE IF EXISTS public.dungeon_enemy_config;
DROP TABLE IF EXISTS public.dungeon;
DROP TABLE IF EXISTS public.cooldowns;
DROP TABLE IF EXISTS public.clan_member;
DROP TABLE IF EXISTS public.clan;
DROP SEQUENCE IF EXISTS public.civilizations_id_seq;
DROP TABLE IF EXISTS public.civilizations;
DROP TABLE IF EXISTS public.character_stats;
DROP TABLE IF EXISTS public.character_skill;
DROP TABLE IF EXISTS public.character_quest;
DROP TABLE IF EXISTS public.character_achievement;
DROP TABLE IF EXISTS public."character";
DROP TABLE IF EXISTS public.battle_log;
DROP TABLE IF EXISTS public.achievement;
-- *not* dropping schema, since initdb creates it
--
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO postgres;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS '';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: achievement; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.achievement (
    achievement_id text NOT NULL,
    code text NOT NULL,
    name text NOT NULL,
    description text,
    category text,
    rarity text,
    reward_json jsonb,
    is_hidden boolean DEFAULT false NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.achievement OWNER TO postgres;

--
-- Name: battle_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.battle_log (
    battle_id text NOT NULL,
    character_id text,
    enemy_id text,
    result text,
    reward_json jsonb,
    created_at timestamp with time zone,
    enemy_power integer,
    enemy_type text
);


ALTER TABLE public.battle_log OWNER TO postgres;

--
-- Name: character; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."character" (
    character_id text NOT NULL,
    player_id text,
    name text,
    race text,
    rank_id text,
    created_at timestamp with time zone,
    character_path text,
    age integer,
    is_alive boolean
);


ALTER TABLE public."character" OWNER TO postgres;

--
-- Name: character_achievement; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.character_achievement (
    character_id text NOT NULL,
    achievement_id text NOT NULL,
    progress integer DEFAULT 0 NOT NULL,
    target_value integer,
    unlocked_at timestamp with time zone,
    claimed_at timestamp with time zone,
    status text DEFAULT 'locked'::text NOT NULL,
    metadata_json jsonb
);


ALTER TABLE public.character_achievement OWNER TO postgres;

--
-- Name: character_quest; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.character_quest (
    character_id text NOT NULL,
    quest_id text NOT NULL,
    status text,
    progress text,
    updated_at timestamp with time zone
);


ALTER TABLE public.character_quest OWNER TO postgres;

--
-- Name: character_skill; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.character_skill (
    character_id text NOT NULL,
    skill_id text NOT NULL,
    level integer,
    unlocked_at timestamp with time zone,
    discovery_method text
);


ALTER TABLE public.character_skill OWNER TO postgres;

--
-- Name: character_stats; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.character_stats (
    defense integer,
    strength integer,
    speed integer,
    mana integer,
    energy integer,
    level integer,
    exp integer,
    gold bigint,
    hp integer,
    hunting_points integer,
    black_knowledge_level integer,
    intelligence integer,
    luck integer,
    character_id text CONSTRAINT player_stats_charecter_id_not_null NOT NULL,
    base_hp integer,
    base_mana integer,
    base_energy integer
);


ALTER TABLE public.character_stats OWNER TO postgres;

--
-- Name: civilizations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.civilizations (
    id integer NOT NULL,
    slug character varying(50) NOT NULL,
    name character varying(100) NOT NULL,
    description text,
    starting_stats_bonus jsonb DEFAULT '{}'::jsonb,
    culture_type character varying(50),
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    starting_location_id text
);


ALTER TABLE public.civilizations OWNER TO postgres;

--
-- Name: civilizations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.civilizations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.civilizations_id_seq OWNER TO postgres;

--
-- Name: civilizations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.civilizations_id_seq OWNED BY public.civilizations.id;


--
-- Name: clan; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.clan (
    clan_id text NOT NULL,
    name text NOT NULL,
    leader_character_id text NOT NULL,
    description text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    is_active boolean DEFAULT true NOT NULL
);


ALTER TABLE public.clan OWNER TO postgres;

--
-- Name: clan_member; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.clan_member (
    clan_id text NOT NULL,
    character_id text NOT NULL,
    member_role text DEFAULT 'member'::text NOT NULL,
    joined_at timestamp with time zone DEFAULT now() NOT NULL,
    left_at timestamp with time zone,
    is_active boolean DEFAULT true NOT NULL
);


ALTER TABLE public.clan_member OWNER TO postgres;

--
-- Name: cooldowns; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cooldowns (
    cooldown_id text NOT NULL,
    character_id text NOT NULL,
    skill_id text,
    action_type text NOT NULL,
    target_id text,
    started_at timestamp with time zone DEFAULT now() NOT NULL,
    ends_at timestamp with time zone NOT NULL,
    is_active boolean DEFAULT true NOT NULL,
    metadata_json jsonb
);


ALTER TABLE public.cooldowns OWNER TO postgres;

--
-- Name: dungeon; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dungeon (
    dungeon_id text NOT NULL,
    name text,
    location_id text,
    description text
);


ALTER TABLE public.dungeon OWNER TO postgres;

--
-- Name: dungeon_enemy_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dungeon_enemy_config (
    dungeon_id text NOT NULL,
    enemy_id text NOT NULL,
    min_count integer,
    max_count integer,
    spawn_weight integer
);


ALTER TABLE public.dungeon_enemy_config OWNER TO postgres;

--
-- Name: dungeon_item_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dungeon_item_config (
    dungeon_id text NOT NULL,
    item_id text NOT NULL,
    min_count integer,
    max_count integer,
    dnx_weight integer
);


ALTER TABLE public.dungeon_item_config OWNER TO postgres;

--
-- Name: economy_ledger; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.economy_ledger (
    ledger_id text NOT NULL,
    wallet_id text NOT NULL,
    player_id text,
    transaction_type text NOT NULL,
    currency_type text NOT NULL,
    amount bigint NOT NULL,
    balance_before bigint,
    balance_after bigint,
    source_type text,
    source_id text,
    note text,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.economy_ledger OWNER TO postgres;

--
-- Name: enemy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.enemy (
    enemy_id text NOT NULL,
    type text,
    name text,
    rank_id text,
    loot_json jsonb,
    location_id text,
    description text,
    rarity_weight integer,
    origin_world text
);


ALTER TABLE public.enemy OWNER TO postgres;

--
-- Name: enemy_instance; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.enemy_instance (
    instance_id text NOT NULL,
    enemy_id text,
    level integer,
    hp integer,
    mana integer,
    location_id text,
    extra_properties text,
    energy integer,
    spawn_at timestamp with time zone
);


ALTER TABLE public.enemy_instance OWNER TO postgres;

--
-- Name: enemy_stats; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.enemy_stats (
    enemy_id text NOT NULL,
    strength integer,
    speed integer,
    mana integer,
    energy integer,
    hp integer,
    luck integer,
    base_hp integer,
    base_mana integer,
    base_energy integer
);


ALTER TABLE public.enemy_stats OWNER TO postgres;

--
-- Name: equipment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.equipment (
    equipment_id text NOT NULL,
    item_id text NOT NULL,
    character_id text NOT NULL,
    slot_type text NOT NULL,
    enhancement_level integer DEFAULT 0 NOT NULL,
    durability integer,
    max_durability integer,
    equipped_at timestamp with time zone DEFAULT now() NOT NULL,
    unequipped_at timestamp with time zone,
    is_equipped boolean DEFAULT true NOT NULL,
    extra_json jsonb
);


ALTER TABLE public.equipment OWNER TO postgres;

--
-- Name: event_history; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.event_history (
    player_id text,
    event_type text,
    event_data jsonb,
    created_at time with time zone,
    event_id text NOT NULL
);


ALTER TABLE public.event_history OWNER TO postgres;

--
-- Name: family_background; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.family_background (
    background_id text NOT NULL,
    name text,
    description text,
    starting_items jsonb,
    start_skill jsonb,
    spawn_weight integer
);


ALTER TABLE public.family_background OWNER TO postgres;

--
-- Name: guild; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.guild (
    guild_id text NOT NULL,
    name text NOT NULL,
    leader_character_id text NOT NULL,
    description text,
    motto text,
    level integer DEFAULT 1 NOT NULL,
    exp bigint DEFAULT 0 NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    is_active boolean DEFAULT true NOT NULL
);


ALTER TABLE public.guild OWNER TO postgres;

--
-- Name: guild_member; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.guild_member (
    guild_id text NOT NULL,
    character_id text NOT NULL,
    member_role text DEFAULT 'member'::text NOT NULL,
    joined_at timestamp with time zone DEFAULT now() NOT NULL,
    left_at timestamp with time zone,
    is_active boolean DEFAULT true NOT NULL
);


ALTER TABLE public.guild_member OWNER TO postgres;

--
-- Name: inventory; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.inventory (
    character_id text NOT NULL,
    item_id text NOT NULL,
    quantity integer
);


ALTER TABLE public.inventory OWNER TO postgres;

--
-- Name: item; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.item (
    item_id text NOT NULL,
    name text,
    rarity text,
    type text,
    description text,
    effect_json jsonb,
    rarity_weight integer
);


ALTER TABLE public.item OWNER TO postgres;

--
-- Name: location; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.location (
    location_id text NOT NULL,
    name text,
    danger_level integer,
    region_type text,
    description text
);


ALTER TABLE public.location OWNER TO postgres;

--
-- Name: location_feature; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.location_feature (
    feature_id text NOT NULL,
    location_id text,
    name text,
    rarity text,
    effect_json jsonb,
    effect_region text,
    weight integer
);


ALTER TABLE public.location_feature OWNER TO postgres;

--
-- Name: login_history; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.login_history (
    login_history_id text NOT NULL,
    player_id text NOT NULL,
    session_id text,
    login_at timestamp with time zone DEFAULT now() NOT NULL,
    logout_at timestamp with time zone,
    ip_address text,
    user_agent text,
    login_status text DEFAULT 'success'::text NOT NULL,
    failure_reason text
);


ALTER TABLE public.login_history OWNER TO postgres;

--
-- Name: market_listing; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.market_listing (
    listing_id text NOT NULL,
    seller_id text NOT NULL,
    item_instance_id text,
    item_id text NOT NULL,
    quantity integer DEFAULT 1,
    price_per_unit bigint NOT NULL,
    currency_type text DEFAULT 'gold'::text,
    created_at timestamp with time zone DEFAULT now(),
    expires_at timestamp with time zone NOT NULL,
    is_sold boolean DEFAULT false,
    is_cancelled boolean DEFAULT false
);


ALTER TABLE public.market_listing OWNER TO postgres;

--
-- Name: message; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.message (
    message_id text NOT NULL,
    sender_player_id text,
    receiver_player_id text,
    sender_character_id text,
    receiver_character_id text,
    subject text,
    body text,
    attachment_json jsonb,
    status text DEFAULT 'sent'::text NOT NULL,
    sent_at timestamp with time zone DEFAULT now() NOT NULL,
    read_at timestamp with time zone
);


ALTER TABLE public.message OWNER TO postgres;

--
-- Name: notification; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.notification (
    notification_id text NOT NULL,
    player_id text NOT NULL,
    character_id text,
    notification_type text NOT NULL,
    title text NOT NULL,
    body text,
    payload_json jsonb,
    is_read boolean DEFAULT false NOT NULL,
    read_at timestamp with time zone,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    expires_at timestamp with time zone
);


ALTER TABLE public.notification OWNER TO postgres;

--
-- Name: npc; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.npc (
    npc_id text NOT NULL,
    name text NOT NULL,
    title text,
    npc_type text NOT NULL,
    description text,
    base_location_id text,
    is_killable boolean DEFAULT false,
    dialogue_json jsonb,
    extra_properties jsonb
);


ALTER TABLE public.npc OWNER TO postgres;

--
-- Name: npc_interaction_rule; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.npc_interaction_rule (
    rule_id text NOT NULL,
    npc_id text NOT NULL,
    required_quest_id text,
    required_level integer,
    trigger_event text,
    response_text text,
    reward_json jsonb
);


ALTER TABLE public.npc_interaction_rule OWNER TO postgres;

--
-- Name: npc_merchant_stock; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.npc_merchant_stock (
    npc_id text NOT NULL,
    item_id text NOT NULL,
    price bigint NOT NULL,
    currency_type text DEFAULT 'gold'::text,
    stock_quantity integer DEFAULT '-1'::integer,
    refresh_time interval
);


ALTER TABLE public.npc_merchant_stock OWNER TO postgres;

--
-- Name: npc_stats; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.npc_stats (
    npc_id text NOT NULL,
    defense integer,
    strength integer,
    speed integer,
    mana integer,
    energy integer,
    level integer,
    exp integer,
    gold integer,
    hp integer,
    hunting_points integer,
    black_knowledge_level integer,
    intelligence integer,
    luck integer,
    base_hp integer,
    base_mana integer,
    base_energy integer
);


ALTER TABLE public.npc_stats OWNER TO postgres;

--
-- Name: party; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.party (
    party_id text NOT NULL,
    name text NOT NULL,
    leader_character_id text NOT NULL,
    party_type text DEFAULT 'party'::text NOT NULL,
    description text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    is_active boolean DEFAULT true NOT NULL
);


ALTER TABLE public.party OWNER TO postgres;

--
-- Name: party_member; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.party_member (
    party_id text NOT NULL,
    character_id text NOT NULL,
    member_role text DEFAULT 'member'::text NOT NULL,
    joined_at timestamp with time zone DEFAULT now() NOT NULL,
    left_at timestamp with time zone,
    is_active boolean DEFAULT true NOT NULL
);


ALTER TABLE public.party_member OWNER TO postgres;

--
-- Name: player; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.player (
    player_id text CONSTRAINT users_id_not_null NOT NULL,
    telegram_id bigint,
    username text,
    created_at timestamp with time zone,
    last_active timestamp with time zone,
    role text,
    is_banned boolean
);


ALTER TABLE public.player OWNER TO postgres;

--
-- Name: player_mail; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.player_mail (
    mail_id text NOT NULL,
    receiver_id text NOT NULL,
    sender_name text DEFAULT 'System'::text,
    subject text NOT NULL,
    body text,
    attachment_json jsonb,
    is_read boolean DEFAULT false,
    is_claimed boolean DEFAULT false,
    sent_at timestamp with time zone DEFAULT now(),
    expires_at timestamp with time zone
);


ALTER TABLE public.player_mail OWNER TO postgres;

--
-- Name: player_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.player_session (
    session_id text NOT NULL,
    player_id text NOT NULL,
    telegram_chat_id text,
    ip_address text,
    user_agent text,
    login_at timestamp with time zone DEFAULT now() NOT NULL,
    last_seen_at timestamp with time zone,
    logout_at timestamp with time zone,
    is_active boolean DEFAULT true NOT NULL,
    refresh_token_hash text
);


ALTER TABLE public.player_session OWNER TO postgres;

--
-- Name: player_state; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.player_state (
    player_id text,
    current_location_id text,
    current_region_id text,
    energy integer,
    step_counter integer,
    last_event_type text,
    seed_value integer,
    last_location_change text,
    last_event_at timestamp with time zone
);


ALTER TABLE public.player_state OWNER TO postgres;

--
-- Name: player_wallet; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.player_wallet (
    wallet_id text NOT NULL,
    player_id text NOT NULL,
    gold_balance bigint DEFAULT 0 NOT NULL,
    gem_balance bigint DEFAULT 0 NOT NULL,
    silver_balance bigint DEFAULT 0 NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.player_wallet OWNER TO postgres;

--
-- Name: quest; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.quest (
    quest_id text NOT NULL,
    name text,
    location_id text,
    difficulty_rank text,
    reward_json jsonb,
    description text
);


ALTER TABLE public.quest OWNER TO postgres;

--
-- Name: race; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.race (
    race_id text NOT NULL,
    name text,
    talent_modifiers jsonb,
    description text,
    spawn_weight integer,
    civilization_id integer,
    base_stats_modifier jsonb
);


ALTER TABLE public.race OWNER TO postgres;

--
-- Name: rank; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rank (
    rank_id text NOT NULL,
    name text,
    power_multiplier text,
    description text
);


ALTER TABLE public.rank OWNER TO postgres;

--
-- Name: skill; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.skill (
    skill_id text NOT NULL,
    name text,
    description text,
    type text,
    mana_cost integer,
    cooldown integer
);


ALTER TABLE public.skill OWNER TO postgres;

--
-- Name: skill_discovery_rule; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.skill_discovery_rule (
    skill_id text NOT NULL,
    activity_type text NOT NULL,
    base_chance text,
    rarity text NOT NULL,
    talent_bonus jsonb
);


ALTER TABLE public.skill_discovery_rule OWNER TO postgres;

--
-- Name: world_environment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.world_environment (
    environment_id text NOT NULL,
    location_id text,
    weather_type text NOT NULL,
    active_buffs_json jsonb,
    started_at timestamp with time zone DEFAULT now(),
    ends_at timestamp with time zone
);


ALTER TABLE public.world_environment OWNER TO postgres;

--
-- Name: world_events; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.world_events (
    id integer NOT NULL,
    event_type character varying,
    description character varying,
    created_at timestamp without time zone
);


ALTER TABLE public.world_events OWNER TO postgres;

--
-- Name: world_events_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.world_events_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.world_events_id_seq OWNER TO postgres;

--
-- Name: world_events_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.world_events_id_seq OWNED BY public.world_events.id;


--
-- Name: world_links; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.world_links (
    id integer NOT NULL,
    source_location_id text,
    target_location_id text,
    link_type character varying(50) DEFAULT 'portal'::character varying,
    is_active boolean DEFAULT true,
    mana_cost integer DEFAULT 0,
    metadata jsonb,
    required_item_id text
);


ALTER TABLE public.world_links OWNER TO postgres;

--
-- Name: world_links_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.world_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.world_links_id_seq OWNER TO postgres;

--
-- Name: world_links_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.world_links_id_seq OWNED BY public.world_links.id;


--
-- Name: world_objects; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.world_objects (
    id integer NOT NULL,
    location_id text,
    object_type character varying(50) NOT NULL,
    state jsonb,
    interaction_logic character varying(100),
    last_interacted_at timestamp with time zone,
    respawn_time_seconds integer
);


ALTER TABLE public.world_objects OWNER TO postgres;

--
-- Name: world_objects_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.world_objects_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.world_objects_id_seq OWNER TO postgres;

--
-- Name: world_objects_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.world_objects_id_seq OWNED BY public.world_objects.id;


--
-- Name: world_rules; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.world_rules (
    id integer NOT NULL,
    rule_key character varying(100) NOT NULL,
    rule_value numeric(10,2) NOT NULL,
    affected_location_id text,
    affected_civilization_id integer,
    expires_at timestamp with time zone
);


ALTER TABLE public.world_rules OWNER TO postgres;

--
-- Name: world_rules_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.world_rules_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.world_rules_id_seq OWNER TO postgres;

--
-- Name: world_rules_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.world_rules_id_seq OWNED BY public.world_rules.id;


--
-- Name: civilizations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.civilizations ALTER COLUMN id SET DEFAULT nextval('public.civilizations_id_seq'::regclass);


--
-- Name: world_events id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.world_events ALTER COLUMN id SET DEFAULT nextval('public.world_events_id_seq'::regclass);


--
-- Name: world_links id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.world_links ALTER COLUMN id SET DEFAULT nextval('public.world_links_id_seq'::regclass);


--
-- Name: world_objects id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.world_objects ALTER COLUMN id SET DEFAULT nextval('public.world_objects_id_seq'::regclass);


--
-- Name: world_rules id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.world_rules ALTER COLUMN id SET DEFAULT nextval('public.world_rules_id_seq'::regclass);


--
-- Data for Name: achievement; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.achievement (achievement_id, code, name, description, category, rarity, reward_json, is_hidden, created_at) FROM stdin;
\.


--
-- Data for Name: battle_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.battle_log (battle_id, character_id, enemy_id, result, reward_json, created_at, enemy_power, enemy_type) FROM stdin;
\.


--
-- Data for Name: character; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."character" (character_id, player_id, name, race, rank_id, created_at, character_path, age, is_alive) FROM stdin;
c0cc9c1d-1e3f-41a1-b451-540946af8587	26b2f592-8ded-430b-a340-ebb59b52d709	Ali GPT	انسان	\N	2026-06-28 11:55:26.766023+00	loc_volcanic_081	10	t
\.


--
-- Data for Name: character_achievement; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.character_achievement (character_id, achievement_id, progress, target_value, unlocked_at, claimed_at, status, metadata_json) FROM stdin;
\.


--
-- Data for Name: character_quest; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.character_quest (character_id, quest_id, status, progress, updated_at) FROM stdin;
\.


--
-- Data for Name: character_skill; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.character_skill (character_id, skill_id, level, unlocked_at, discovery_method) FROM stdin;
\.


--
-- Data for Name: character_stats; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.character_stats (defense, strength, speed, mana, energy, level, exp, gold, hp, hunting_points, black_knowledge_level, intelligence, luck, character_id, base_hp, base_mana, base_energy) FROM stdin;
5	5	5	27	69	2	5	100	120	0	\N	3	3	c0cc9c1d-1e3f-41a1-b451-540946af8587	120	30	70
\.


--
-- Data for Name: civilizations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.civilizations (id, slug, name, description, starting_stats_bonus, culture_type, created_at, starting_location_id) FROM stdin;
1	great-man	تمدن بزرگ مرد	تمدنی متکی بر قدرت بدنی، نظام سخت‌گیرانه شکار از کودکی تا بزرگسالی و بقا در طبیعت وحشی.	{"hp": 50, "strength": 5, "hunting_points": 10}	Tribal/Hunting	2026-06-06 15:01:55.71488+00	\N
2	super-man	تمدن ابر مرد	تمدنی پیشرفته، ماکیاولیستی و متکی بر مطالعه، جادو، فناوری‌های باستانی و دانش سیاه.	{"mana": 80, "intelligence": 8, "black_knowledge_level": 2}	Magical/Scholar	2026-06-06 15:01:55.71488+00	\N
\.


--
-- Data for Name: clan; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.clan (clan_id, name, leader_character_id, description, created_at, updated_at, is_active) FROM stdin;
\.


--
-- Data for Name: clan_member; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.clan_member (clan_id, character_id, member_role, joined_at, left_at, is_active) FROM stdin;
\.


--
-- Data for Name: cooldowns; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cooldowns (cooldown_id, character_id, skill_id, action_type, target_id, started_at, ends_at, is_active, metadata_json) FROM stdin;
\.


--
-- Data for Name: dungeon; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dungeon (dungeon_id, name, location_id, description) FROM stdin;
\.


--
-- Data for Name: dungeon_enemy_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dungeon_enemy_config (dungeon_id, enemy_id, min_count, max_count, spawn_weight) FROM stdin;
\.


--
-- Data for Name: dungeon_item_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dungeon_item_config (dungeon_id, item_id, min_count, max_count, dnx_weight) FROM stdin;
\.


--
-- Data for Name: economy_ledger; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.economy_ledger (ledger_id, wallet_id, player_id, transaction_type, currency_type, amount, balance_before, balance_after, source_type, source_id, note, created_at) FROM stdin;
\.


--
-- Data for Name: enemy; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.enemy (enemy_id, type, name, rank_id, loot_json, location_id, description, rarity_weight, origin_world) FROM stdin;
enemy_abyss_000	Abyss	شبح خلاء سایه‌های سرگردان	rank_e	{"gold_max": 100, "gold_min": 10, "possible_drops": ["item_volcanic_029"]}	loc_abyss_000	موجودی خطرناک به نام شبح خلاء سایه‌های سرگردان که در مناطق Abyss پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	39	Sylora
enemy_volcanic_001	Volcanic	شکارچی خاکستر سنگ جهنمی	rank_d	{"gold_max": 150, "gold_min": 15, "possible_drops": ["item_arcane_007"]}	loc_volcanic_001	موجودی خطرناک به نام شکارچی خاکستر سنگ جهنمی که در مناطق Volcanic پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	26	Sylora
enemy_glacial_002	Glacial	غول یخی کولاک ابدی	rank_c	{"gold_max": 220, "gold_min": 22, "possible_drops": ["item_volcanic_149"]}	loc_glacial_002	موجودی خطرناک به نام غول یخی کولاک ابدی که در مناطق Glacial پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	2	Sylora
enemy_arcane_003	Arcane	جادوگر مرتد انرژی‌های کیهانی	rank_b	{"gold_max": 300, "gold_min": 30, "possible_drops": ["item_abyss_004"]}	loc_arcane_003	موجودی خطرناک به نام جادوگر مرتد انرژی‌های کیهانی که در مناطق Arcane پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	79	Sylora
enemy_abyss_004	Abyss	خزنده سایه خلاء	rank_a	{"gold_max": 450, "gold_min": 45, "possible_drops": ["item_arcane_135"]}	loc_abyss_004	موجودی خطرناک به نام خزنده سایه خلاء که در مناطق Abyss پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	64	Sylora
enemy_volcanic_005	Volcanic	شکارچی خاکستر گدازه مذاب	rank_s	{"gold_max": 650, "gold_min": 65, "possible_drops": ["item_abyss_096"]}	loc_volcanic_005	موجودی خطرناک به نام شکارچی خاکستر گدازه مذاب که در مناطق Volcanic پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	3	Sylora
enemy_glacial_006	Glacial	گرگ کولاک یخبندان شمالی	rank_ss	{"gold_max": 900, "gold_min": 90, "possible_drops": ["item_volcanic_149"]}	loc_glacial_006	موجودی خطرناک به نام گرگ کولاک یخبندان شمالی که در مناطق Glacial پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	21	Sylora
enemy_arcane_007	Arcane	عنصر مانا انرژی‌های کیهانی	rank_sss	{"gold_max": 1500, "gold_min": 150, "possible_drops": ["item_volcanic_121"]}	loc_arcane_007	موجودی خطرناک به نام عنصر مانا انرژی‌های کیهانی که در مناطق Arcane پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	85	Sylora
enemy_abyss_008	Abyss	بلعنده روح خلاء	rank_e	{"gold_max": 100, "gold_min": 10, "possible_drops": ["item_abyss_028"]}	loc_abyss_008	موجودی خطرناک به نام بلعنده روح خلاء که در مناطق Abyss پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	91	Sylora
enemy_volcanic_009	Volcanic	دیو گدازه خاکستر سرخ	rank_d	{"gold_max": 150, "gold_min": 15, "possible_drops": ["item_glacial_038"]}	loc_volcanic_009	موجودی خطرناک به نام دیو گدازه خاکستر سرخ که در مناطق Volcanic پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	66	Sylora
enemy_glacial_010	Glacial	غول یخی زمستان تاریک	rank_c	{"gold_max": 220, "gold_min": 22, "possible_drops": ["item_glacial_106"]}	loc_glacial_010	موجودی خطرناک به نام غول یخی زمستان تاریک که در مناطق Glacial پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	31	Sylora
enemy_arcane_011	Arcane	جادوگر مرتد جادوی کهن	rank_b	{"gold_max": 300, "gold_min": 30, "possible_drops": ["item_abyss_056"]}	loc_arcane_011	موجودی خطرناک به نام جادوگر مرتد جادوی کهن که در مناطق Arcane پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	79	Sylora
enemy_abyss_012	Abyss	هیولای گنداب ظلمت	rank_a	{"gold_max": 450, "gold_min": 45, "possible_drops": ["item_abyss_056"]}	loc_abyss_012	موجودی خطرناک به نام هیولای گنداب ظلمت که در مناطق Abyss پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	7	Sylora
enemy_volcanic_013	Volcanic	سگ دوزخی سنگ جهنمی	rank_s	{"gold_max": 650, "gold_min": 65, "possible_drops": ["item_volcanic_037"]}	loc_volcanic_013	موجودی خطرناک به نام سگ دوزخی سنگ جهنمی که در مناطق Volcanic پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	53	Sylora
enemy_glacial_014	Glacial	خرس قطبی وحشی سرمای استخوان‌سوز	rank_ss	{"gold_max": 900, "gold_min": 90, "possible_drops": ["item_arcane_119"]}	loc_glacial_014	موجودی خطرناک به نام خرس قطبی وحشی سرمای استخوان‌سوز که در مناطق Glacial پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	95	Sylora
enemy_arcane_015	Arcane	توهم نوری جادوی کهن	rank_sss	{"gold_max": 1500, "gold_min": 150, "possible_drops": ["item_abyss_136"]}	loc_arcane_015	موجودی خطرناک به نام توهم نوری جادوی کهن که در مناطق Arcane پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	81	Sylora
enemy_abyss_016	Abyss	خزنده سایه سایه‌های سرگردان	rank_e	{"gold_max": 100, "gold_min": 10, "possible_drops": ["item_abyss_144"]}	loc_abyss_016	موجودی خطرناک به نام خزنده سایه سایه‌های سرگردان که در مناطق Abyss پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	50	Sylora
enemy_volcanic_017	Volcanic	اژدهای خفته خاکستر سرخ	rank_d	{"gold_max": 150, "gold_min": 15, "possible_drops": ["item_arcane_131"]}	loc_volcanic_017	موجودی خطرناک به نام اژدهای خفته خاکستر سرخ که در مناطق Volcanic پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	49	Sylora
enemy_glacial_018	Glacial	خرس قطبی وحشی زمستان تاریک	rank_c	{"gold_max": 220, "gold_min": 22, "possible_drops": ["item_abyss_060"]}	loc_glacial_018	موجودی خطرناک به نام خرس قطبی وحشی زمستان تاریک که در مناطق Glacial پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	13	Sylora
enemy_arcane_019	Arcane	عنصر مانا ستاره‌شناسان	rank_b	{"gold_max": 300, "gold_min": 30, "possible_drops": ["item_glacial_010"]}	loc_arcane_019	موجودی خطرناک به نام عنصر مانا ستاره‌شناسان که در مناطق Arcane پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	54	Sylora
enemy_abyss_020	Abyss	هیولای گنداب سایه‌های سرگردان	rank_a	{"gold_max": 450, "gold_min": 45, "possible_drops": ["item_glacial_022"]}	loc_abyss_020	موجودی خطرناک به نام هیولای گنداب سایه‌های سرگردان که در مناطق Abyss پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	51	Sylora
enemy_volcanic_021	Volcanic	دیو گدازه گدازه مذاب	rank_s	{"gold_max": 650, "gold_min": 65, "possible_drops": ["item_arcane_067"]}	loc_volcanic_021	موجودی خطرناک به نام دیو گدازه گدازه مذاب که در مناطق Volcanic پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	75	Sylora
enemy_glacial_022	Glacial	خرس قطبی وحشی سرمای استخوان‌سوز	rank_ss	{"gold_max": 900, "gold_min": 90, "possible_drops": ["item_volcanic_077"]}	loc_glacial_022	موجودی خطرناک به نام خرس قطبی وحشی سرمای استخوان‌سوز که در مناطق Glacial پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	9	Sylora
enemy_arcane_023	Arcane	توهم نوری انرژی‌های کیهانی	rank_sss	{"gold_max": 1500, "gold_min": 150, "possible_drops": ["item_abyss_080"]}	loc_arcane_023	موجودی خطرناک به نام توهم نوری انرژی‌های کیهانی که در مناطق Arcane پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	92	Sylora
enemy_abyss_024	Abyss	نگهبان تاریکی ظلمت	rank_e	{"gold_max": 100, "gold_min": 10, "possible_drops": ["item_arcane_023"]}	loc_abyss_024	موجودی خطرناک به نام نگهبان تاریکی ظلمت که در مناطق Abyss پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	47	Sylora
enemy_volcanic_025	Volcanic	شکارچی خاکستر آتش ابدی	rank_d	{"gold_max": 150, "gold_min": 15, "possible_drops": ["item_arcane_039"]}	loc_volcanic_025	موجودی خطرناک به نام شکارچی خاکستر آتش ابدی که در مناطق Volcanic پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	35	Sylora
enemy_glacial_026	Glacial	شبح منجمد بلورهای جادویی	rank_c	{"gold_max": 220, "gold_min": 22, "possible_drops": ["item_abyss_084"]}	loc_glacial_026	موجودی خطرناک به نام شبح منجمد بلورهای جادویی که در مناطق Glacial پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	86	Sylora
enemy_arcane_027	Arcane	جادوگر مرتد اسرار باستانی	rank_b	{"gold_max": 300, "gold_min": 30, "possible_drops": ["item_arcane_107"]}	loc_arcane_027	موجودی خطرناک به نام جادوگر مرتد اسرار باستانی که در مناطق Arcane پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	92	Sylora
enemy_abyss_028	Abyss	بلعنده روح فاسد شده	rank_a	{"gold_max": 450, "gold_min": 45, "possible_drops": ["item_arcane_039"]}	loc_abyss_028	موجودی خطرناک به نام بلعنده روح فاسد شده که در مناطق Abyss پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	24	Sylora
enemy_volcanic_029	Volcanic	شکارچی خاکستر خاکستر سرخ	rank_s	{"gold_max": 650, "gold_min": 65, "possible_drops": ["item_volcanic_081"]}	loc_volcanic_029	موجودی خطرناک به نام شکارچی خاکستر خاکستر سرخ که در مناطق Volcanic پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	59	Sylora
enemy_glacial_030	Glacial	شبح منجمد سرمای استخوان‌سوز	rank_ss	{"gold_max": 900, "gold_min": 90, "possible_drops": ["item_arcane_123"]}	loc_glacial_030	موجودی خطرناک به نام شبح منجمد سرمای استخوان‌سوز که در مناطق Glacial پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	97	Sylora
enemy_arcane_031	Arcane	کتاب جادویی سرگردان مانای سرکش	rank_sss	{"gold_max": 1500, "gold_min": 150, "possible_drops": ["item_volcanic_021"]}	loc_arcane_031	موجودی خطرناک به نام کتاب جادویی سرگردان مانای سرکش که در مناطق Arcane پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	10	Sylora
enemy_abyss_032	Abyss	هیولای گنداب ظلمت	rank_e	{"gold_max": 100, "gold_min": 10, "possible_drops": ["item_volcanic_045"]}	loc_abyss_032	موجودی خطرناک به نام هیولای گنداب ظلمت که در مناطق Abyss پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	45	Sylora
enemy_volcanic_033	Volcanic	سگ دوزخی آتشفشان	rank_d	{"gold_max": 150, "gold_min": 15, "possible_drops": ["item_abyss_064"]}	loc_volcanic_033	موجودی خطرناک به نام سگ دوزخی آتشفشان که در مناطق Volcanic پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	71	Sylora
enemy_glacial_034	Glacial	غول یخی کولاک ابدی	rank_c	{"gold_max": 220, "gold_min": 22, "possible_drops": ["item_glacial_058"]}	loc_glacial_034	موجودی خطرناک به نام غول یخی کولاک ابدی که در مناطق Glacial پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	89	Sylora
enemy_arcane_035	Arcane	توهم نوری اسرار باستانی	rank_b	{"gold_max": 300, "gold_min": 30, "possible_drops": ["item_abyss_076"]}	loc_arcane_035	موجودی خطرناک به نام توهم نوری اسرار باستانی که در مناطق Arcane پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	66	Sylora
enemy_abyss_036	Abyss	خزنده سایه فاسد شده	rank_a	{"gold_max": 450, "gold_min": 45, "possible_drops": ["item_abyss_036"]}	loc_abyss_036	موجودی خطرناک به نام خزنده سایه فاسد شده که در مناطق Abyss پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	22	Sylora
enemy_volcanic_037	Volcanic	دیو گدازه آتش ابدی	rank_s	{"gold_max": 650, "gold_min": 65, "possible_drops": ["item_arcane_079"]}	loc_volcanic_037	موجودی خطرناک به نام دیو گدازه آتش ابدی که در مناطق Volcanic پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	67	Sylora
enemy_glacial_038	Glacial	گرگ کولاک کولاک ابدی	rank_ss	{"gold_max": 900, "gold_min": 90, "possible_drops": ["item_volcanic_141"]}	loc_glacial_038	موجودی خطرناک به نام گرگ کولاک کولاک ابدی که در مناطق Glacial پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	94	Sylora
enemy_arcane_039	Arcane	عنصر مانا اسرار باستانی	rank_sss	{"gold_max": 1500, "gold_min": 150, "possible_drops": ["item_glacial_030"]}	loc_arcane_039	موجودی خطرناک به نام عنصر مانا اسرار باستانی که در مناطق Arcane پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	17	Sylora
enemy_abyss_040	Abyss	بلعنده روح فاسد شده	rank_e	{"gold_max": 100, "gold_min": 10, "possible_drops": ["item_volcanic_109"]}	loc_abyss_040	موجودی خطرناک به نام بلعنده روح فاسد شده که در مناطق Abyss پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	69	Sylora
enemy_volcanic_041	Volcanic	سگ دوزخی آتش ابدی	rank_d	{"gold_max": 150, "gold_min": 15, "possible_drops": ["item_arcane_007"]}	loc_volcanic_041	موجودی خطرناک به نام سگ دوزخی آتش ابدی که در مناطق Volcanic پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	45	Sylora
enemy_glacial_042	Glacial	گرگ کولاک سرمای استخوان‌سوز	rank_c	{"gold_max": 220, "gold_min": 22, "possible_drops": ["item_abyss_040"]}	loc_glacial_042	موجودی خطرناک به نام گرگ کولاک سرمای استخوان‌سوز که در مناطق Glacial پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	30	Sylora
enemy_arcane_043	Arcane	عنصر مانا انرژی‌های کیهانی	rank_b	{"gold_max": 300, "gold_min": 30, "possible_drops": ["item_arcane_103"]}	loc_arcane_043	موجودی خطرناک به نام عنصر مانا انرژی‌های کیهانی که در مناطق Arcane پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	55	Sylora
enemy_abyss_044	Abyss	خزنده سایه سایه‌های سرگردان	rank_a	{"gold_max": 450, "gold_min": 45, "possible_drops": ["item_volcanic_073"]}	loc_abyss_044	موجودی خطرناک به نام خزنده سایه سایه‌های سرگردان که در مناطق Abyss پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	33	Sylora
enemy_volcanic_045	Volcanic	اژدهای خفته خاکستر سرخ	rank_s	{"gold_max": 650, "gold_min": 65, "possible_drops": ["item_abyss_136"]}	loc_volcanic_045	موجودی خطرناک به نام اژدهای خفته خاکستر سرخ که در مناطق Volcanic پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	75	Sylora
enemy_glacial_046	Glacial	خرس قطبی وحشی زمستان تاریک	rank_ss	{"gold_max": 900, "gold_min": 90, "possible_drops": ["item_abyss_004"]}	loc_glacial_046	موجودی خطرناک به نام خرس قطبی وحشی زمستان تاریک که در مناطق Glacial پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	25	Sylora
enemy_arcane_047	Arcane	عنصر مانا اسرار باستانی	rank_sss	{"gold_max": 1500, "gold_min": 150, "possible_drops": ["item_abyss_112"]}	loc_arcane_047	موجودی خطرناک به نام عنصر مانا اسرار باستانی که در مناطق Arcane پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	27	Sylora
enemy_abyss_048	Abyss	بلعنده روح ظلمت	rank_e	{"gold_max": 100, "gold_min": 10, "possible_drops": ["item_abyss_136"]}	loc_abyss_048	موجودی خطرناک به نام بلعنده روح ظلمت که در مناطق Abyss پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	11	Sylora
enemy_volcanic_049	Volcanic	شکارچی خاکستر آتشفشان	rank_d	{"gold_max": 150, "gold_min": 15, "possible_drops": ["item_abyss_088"]}	loc_volcanic_049	موجودی خطرناک به نام شکارچی خاکستر آتشفشان که در مناطق Volcanic پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	8	Sylora
enemy_glacial_050	Glacial	نگهبان بلورین سرمای استخوان‌سوز	rank_c	{"gold_max": 220, "gold_min": 22, "possible_drops": ["item_abyss_132"]}	loc_glacial_050	موجودی خطرناک به نام نگهبان بلورین سرمای استخوان‌سوز که در مناطق Glacial پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	90	Sylora
enemy_arcane_051	Arcane	عنصر مانا جادوی کهن	rank_b	{"gold_max": 300, "gold_min": 30, "possible_drops": ["item_abyss_076"]}	loc_arcane_051	موجودی خطرناک به نام عنصر مانا جادوی کهن که در مناطق Arcane پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	49	Sylora
enemy_abyss_052	Abyss	بلعنده روح سایه‌های سرگردان	rank_a	{"gold_max": 450, "gold_min": 45, "possible_drops": ["item_arcane_131"]}	loc_abyss_052	موجودی خطرناک به نام بلعنده روح سایه‌های سرگردان که در مناطق Abyss پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	38	Sylora
enemy_volcanic_053	Volcanic	شکارچی خاکستر خاکستر سرخ	rank_s	{"gold_max": 650, "gold_min": 65, "possible_drops": ["item_glacial_046"]}	loc_volcanic_053	موجودی خطرناک به نام شکارچی خاکستر خاکستر سرخ که در مناطق Volcanic پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	9	Sylora
enemy_glacial_054	Glacial	نگهبان بلورین کولاک ابدی	rank_ss	{"gold_max": 900, "gold_min": 90, "possible_drops": ["item_arcane_139"]}	loc_glacial_054	موجودی خطرناک به نام نگهبان بلورین کولاک ابدی که در مناطق Glacial پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	81	Sylora
enemy_arcane_055	Arcane	جادوگر مرتد انرژی‌های کیهانی	rank_sss	{"gold_max": 1500, "gold_min": 150, "possible_drops": ["item_arcane_067"]}	loc_arcane_055	موجودی خطرناک به نام جادوگر مرتد انرژی‌های کیهانی که در مناطق Arcane پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	63	Sylora
enemy_abyss_056	Abyss	نگهبان تاریکی مرگ ابدی	rank_e	{"gold_max": 100, "gold_min": 10, "possible_drops": ["item_arcane_123"]}	loc_abyss_056	موجودی خطرناک به نام نگهبان تاریکی مرگ ابدی که در مناطق Abyss پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	75	Sylora
enemy_volcanic_057	Volcanic	عنصر آتش گدازه مذاب	rank_d	{"gold_max": 150, "gold_min": 15, "possible_drops": ["item_volcanic_065"]}	loc_volcanic_057	موجودی خطرناک به نام عنصر آتش گدازه مذاب که در مناطق Volcanic پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	49	Sylora
enemy_glacial_058	Glacial	شبح منجمد بلورهای جادویی	rank_c	{"gold_max": 220, "gold_min": 22, "possible_drops": ["item_arcane_099"]}	loc_glacial_058	موجودی خطرناک به نام شبح منجمد بلورهای جادویی که در مناطق Glacial پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	27	Sylora
enemy_arcane_059	Arcane	کتاب جادویی سرگردان اسرار باستانی	rank_b	{"gold_max": 300, "gold_min": 30, "possible_drops": ["item_volcanic_097"]}	loc_arcane_059	موجودی خطرناک به نام کتاب جادویی سرگردان اسرار باستانی که در مناطق Arcane پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	29	Sylora
enemy_abyss_060	Abyss	شبح خلاء ظلمت	rank_a	{"gold_max": 450, "gold_min": 45, "possible_drops": ["item_glacial_146"]}	loc_abyss_060	موجودی خطرناک به نام شبح خلاء ظلمت که در مناطق Abyss پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	20	Sylora
enemy_volcanic_061	Volcanic	سگ دوزخی خاکستر سرخ	rank_s	{"gold_max": 650, "gold_min": 65, "possible_drops": ["item_volcanic_093"]}	loc_volcanic_061	موجودی خطرناک به نام سگ دوزخی خاکستر سرخ که در مناطق Volcanic پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	100	Sylora
enemy_glacial_062	Glacial	گرگ کولاک کولاک ابدی	rank_ss	{"gold_max": 900, "gold_min": 90, "possible_drops": ["item_arcane_083"]}	loc_glacial_062	موجودی خطرناک به نام گرگ کولاک کولاک ابدی که در مناطق Glacial پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	1	Sylora
enemy_arcane_063	Arcane	جادوگر مرتد مانای سرکش	rank_sss	{"gold_max": 1500, "gold_min": 150, "possible_drops": ["item_glacial_070"]}	loc_arcane_063	موجودی خطرناک به نام جادوگر مرتد مانای سرکش که در مناطق Arcane پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	23	Sylora
enemy_abyss_064	Abyss	خزنده سایه مرگ ابدی	rank_e	{"gold_max": 100, "gold_min": 10, "possible_drops": ["item_arcane_015"]}	loc_abyss_064	موجودی خطرناک به نام خزنده سایه مرگ ابدی که در مناطق Abyss پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	15	Sylora
enemy_volcanic_065	Volcanic	شکارچی خاکستر آتشفشان	rank_d	{"gold_max": 150, "gold_min": 15, "possible_drops": ["item_abyss_136"]}	loc_volcanic_065	موجودی خطرناک به نام شکارچی خاکستر آتشفشان که در مناطق Volcanic پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	16	Sylora
enemy_glacial_066	Glacial	شبح منجمد کولاک ابدی	rank_c	{"gold_max": 220, "gold_min": 22, "possible_drops": ["item_glacial_122"]}	loc_glacial_066	موجودی خطرناک به نام شبح منجمد کولاک ابدی که در مناطق Glacial پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	8	Sylora
enemy_arcane_067	Arcane	عنصر مانا مانای سرکش	rank_b	{"gold_max": 300, "gold_min": 30, "possible_drops": ["item_volcanic_117"]}	loc_arcane_067	موجودی خطرناک به نام عنصر مانا مانای سرکش که در مناطق Arcane پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	70	Sylora
enemy_abyss_068	Abyss	بلعنده روح سایه‌های سرگردان	rank_a	{"gold_max": 450, "gold_min": 45, "possible_drops": ["item_glacial_146"]}	loc_abyss_068	موجودی خطرناک به نام بلعنده روح سایه‌های سرگردان که در مناطق Abyss پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	50	Sylora
enemy_volcanic_069	Volcanic	شکارچی خاکستر خاکستر سرخ	rank_s	{"gold_max": 650, "gold_min": 65, "possible_drops": ["item_abyss_132"]}	loc_volcanic_069	موجودی خطرناک به نام شکارچی خاکستر خاکستر سرخ که در مناطق Volcanic پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	78	Sylora
enemy_glacial_070	Glacial	نگهبان بلورین سرمای استخوان‌سوز	rank_ss	{"gold_max": 900, "gold_min": 90, "possible_drops": ["item_arcane_099"]}	loc_glacial_070	موجودی خطرناک به نام نگهبان بلورین سرمای استخوان‌سوز که در مناطق Glacial پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	84	Sylora
enemy_arcane_071	Arcane	عنصر مانا اسرار باستانی	rank_sss	{"gold_max": 1500, "gold_min": 150, "possible_drops": ["item_glacial_094"]}	loc_arcane_071	موجودی خطرناک به نام عنصر مانا اسرار باستانی که در مناطق Arcane پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	14	Sylora
enemy_abyss_072	Abyss	نگهبان تاریکی خلاء	rank_e	{"gold_max": 100, "gold_min": 10, "possible_drops": ["item_glacial_142"]}	loc_abyss_072	موجودی خطرناک به نام نگهبان تاریکی خلاء که در مناطق Abyss پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	96	Sylora
enemy_volcanic_073	Volcanic	اژدهای خفته خاکستر سرخ	rank_d	{"gold_max": 150, "gold_min": 15, "possible_drops": ["item_arcane_015"]}	loc_volcanic_073	موجودی خطرناک به نام اژدهای خفته خاکستر سرخ که در مناطق Volcanic پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	29	Sylora
enemy_glacial_074	Glacial	شبح منجمد زمستان تاریک	rank_c	{"gold_max": 220, "gold_min": 22, "possible_drops": ["item_glacial_082"]}	loc_glacial_074	موجودی خطرناک به نام شبح منجمد زمستان تاریک که در مناطق Glacial پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	53	Sylora
enemy_arcane_075	Arcane	عنصر مانا جادوی کهن	rank_b	{"gold_max": 300, "gold_min": 30, "possible_drops": ["item_glacial_106"]}	loc_arcane_075	موجودی خطرناک به نام عنصر مانا جادوی کهن که در مناطق Arcane پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	69	Sylora
enemy_abyss_076	Abyss	بلعنده روح خلاء	rank_a	{"gold_max": 450, "gold_min": 45, "possible_drops": ["item_abyss_068"]}	loc_abyss_076	موجودی خطرناک به نام بلعنده روح خلاء که در مناطق Abyss پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	90	Sylora
enemy_volcanic_077	Volcanic	شکارچی خاکستر آتش ابدی	rank_s	{"gold_max": 650, "gold_min": 65, "possible_drops": ["item_volcanic_093"]}	loc_volcanic_077	موجودی خطرناک به نام شکارچی خاکستر آتش ابدی که در مناطق Volcanic پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	3	Sylora
enemy_glacial_078	Glacial	نگهبان بلورین زمستان تاریک	rank_ss	{"gold_max": 900, "gold_min": 90, "possible_drops": ["item_arcane_103"]}	loc_glacial_078	موجودی خطرناک به نام نگهبان بلورین زمستان تاریک که در مناطق Glacial پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	99	Sylora
enemy_arcane_079	Arcane	کتاب جادویی سرگردان انرژی‌های کیهانی	rank_sss	{"gold_max": 1500, "gold_min": 150, "possible_drops": ["item_volcanic_149"]}	loc_arcane_079	موجودی خطرناک به نام کتاب جادویی سرگردان انرژی‌های کیهانی که در مناطق Arcane پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	98	Sylora
enemy_abyss_080	Abyss	بلعنده روح ظلمت	rank_e	{"gold_max": 100, "gold_min": 10, "possible_drops": ["item_arcane_031"]}	loc_abyss_080	موجودی خطرناک به نام بلعنده روح ظلمت که در مناطق Abyss پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	58	Sylora
enemy_volcanic_081	Volcanic	شکارچی خاکستر گدازه مذاب	rank_d	{"gold_max": 150, "gold_min": 15, "possible_drops": ["item_abyss_112"]}	loc_volcanic_081	موجودی خطرناک به نام شکارچی خاکستر گدازه مذاب که در مناطق Volcanic پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	66	Sylora
enemy_glacial_082	Glacial	غول یخی سرمای استخوان‌سوز	rank_c	{"gold_max": 220, "gold_min": 22, "possible_drops": ["item_arcane_119"]}	loc_glacial_082	موجودی خطرناک به نام غول یخی سرمای استخوان‌سوز که در مناطق Glacial پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	20	Sylora
enemy_arcane_083	Arcane	نگهبان ارگ اسرار باستانی	rank_b	{"gold_max": 300, "gold_min": 30, "possible_drops": ["item_glacial_074"]}	loc_arcane_083	موجودی خطرناک به نام نگهبان ارگ اسرار باستانی که در مناطق Arcane پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	10	Sylora
enemy_abyss_084	Abyss	هیولای گنداب فاسد شده	rank_a	{"gold_max": 450, "gold_min": 45, "possible_drops": ["item_abyss_036"]}	loc_abyss_084	موجودی خطرناک به نام هیولای گنداب فاسد شده که در مناطق Abyss پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	1	Sylora
enemy_volcanic_085	Volcanic	شکارچی خاکستر سنگ جهنمی	rank_s	{"gold_max": 650, "gold_min": 65, "possible_drops": ["item_arcane_007"]}	loc_volcanic_085	موجودی خطرناک به نام شکارچی خاکستر سنگ جهنمی که در مناطق Volcanic پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	14	Sylora
enemy_glacial_086	Glacial	غول یخی یخبندان شمالی	rank_ss	{"gold_max": 900, "gold_min": 90, "possible_drops": ["item_volcanic_009"]}	loc_glacial_086	موجودی خطرناک به نام غول یخی یخبندان شمالی که در مناطق Glacial پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	75	Sylora
enemy_arcane_087	Arcane	توهم نوری ستاره‌شناسان	rank_sss	{"gold_max": 1500, "gold_min": 150, "possible_drops": ["item_abyss_072"]}	loc_arcane_087	موجودی خطرناک به نام توهم نوری ستاره‌شناسان که در مناطق Arcane پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	42	Sylora
enemy_abyss_088	Abyss	خزنده سایه مرگ ابدی	rank_e	{"gold_max": 100, "gold_min": 10, "possible_drops": ["item_abyss_080"]}	loc_abyss_088	موجودی خطرناک به نام خزنده سایه مرگ ابدی که در مناطق Abyss پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	24	Sylora
enemy_volcanic_089	Volcanic	اژدهای خفته خاکستر سرخ	rank_d	{"gold_max": 150, "gold_min": 15, "possible_drops": ["item_abyss_024"]}	loc_volcanic_089	موجودی خطرناک به نام اژدهای خفته خاکستر سرخ که در مناطق Volcanic پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	68	Sylora
enemy_glacial_090	Glacial	خرس قطبی وحشی کولاک ابدی	rank_c	{"gold_max": 220, "gold_min": 22, "possible_drops": ["item_volcanic_017"]}	loc_glacial_090	موجودی خطرناک به نام خرس قطبی وحشی کولاک ابدی که در مناطق Glacial پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	32	Sylora
enemy_arcane_091	Arcane	جادوگر مرتد جادوی کهن	rank_b	{"gold_max": 300, "gold_min": 30, "possible_drops": ["item_glacial_122"]}	loc_arcane_091	موجودی خطرناک به نام جادوگر مرتد جادوی کهن که در مناطق Arcane پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	28	Sylora
enemy_abyss_092	Abyss	شبح خلاء مرگ ابدی	rank_a	{"gold_max": 450, "gold_min": 45, "possible_drops": ["item_glacial_146"]}	loc_abyss_092	موجودی خطرناک به نام شبح خلاء مرگ ابدی که در مناطق Abyss پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	90	Sylora
enemy_volcanic_093	Volcanic	شکارچی خاکستر آتش ابدی	rank_s	{"gold_max": 650, "gold_min": 65, "possible_drops": ["item_volcanic_081"]}	loc_volcanic_093	موجودی خطرناک به نام شکارچی خاکستر آتش ابدی که در مناطق Volcanic پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	20	Sylora
enemy_glacial_094	Glacial	نگهبان بلورین کولاک ابدی	rank_ss	{"gold_max": 900, "gold_min": 90, "possible_drops": ["item_arcane_027"]}	loc_glacial_094	موجودی خطرناک به نام نگهبان بلورین کولاک ابدی که در مناطق Glacial پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	96	Sylora
enemy_arcane_095	Arcane	توهم نوری مانای سرکش	rank_sss	{"gold_max": 1500, "gold_min": 150, "possible_drops": ["item_glacial_126"]}	loc_arcane_095	موجودی خطرناک به نام توهم نوری مانای سرکش که در مناطق Arcane پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	44	Sylora
enemy_abyss_096	Abyss	بلعنده روح ظلمت	rank_e	{"gold_max": 100, "gold_min": 10, "possible_drops": ["item_abyss_108"]}	loc_abyss_096	موجودی خطرناک به نام بلعنده روح ظلمت که در مناطق Abyss پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	63	Sylora
enemy_volcanic_097	Volcanic	شکارچی خاکستر آتش ابدی	rank_d	{"gold_max": 150, "gold_min": 15, "possible_drops": ["item_glacial_002"]}	loc_volcanic_097	موجودی خطرناک به نام شکارچی خاکستر آتش ابدی که در مناطق Volcanic پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	91	Sylora
enemy_glacial_098	Glacial	غول یخی زمستان تاریک	rank_c	{"gold_max": 220, "gold_min": 22, "possible_drops": ["item_glacial_030"]}	loc_glacial_098	موجودی خطرناک به نام غول یخی زمستان تاریک که در مناطق Glacial پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	41	Sylora
enemy_arcane_099	Arcane	کتاب جادویی سرگردان جادوی کهن	rank_b	{"gold_max": 300, "gold_min": 30, "possible_drops": ["item_glacial_034"]}	loc_arcane_099	موجودی خطرناک به نام کتاب جادویی سرگردان جادوی کهن که در مناطق Arcane پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	98	Sylora
enemy_abyss_100	Abyss	خزنده سایه فاسد شده	rank_a	{"gold_max": 450, "gold_min": 45, "possible_drops": ["item_glacial_142"]}	loc_abyss_000	موجودی خطرناک به نام خزنده سایه فاسد شده که در مناطق Abyss پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	40	Sylora
enemy_volcanic_101	Volcanic	سگ دوزخی آتش ابدی	rank_s	{"gold_max": 650, "gold_min": 65, "possible_drops": ["item_volcanic_097"]}	loc_volcanic_001	موجودی خطرناک به نام سگ دوزخی آتش ابدی که در مناطق Volcanic پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	78	Sylora
enemy_glacial_102	Glacial	خرس قطبی وحشی کولاک ابدی	rank_ss	{"gold_max": 900, "gold_min": 90, "possible_drops": ["item_abyss_084"]}	loc_glacial_002	موجودی خطرناک به نام خرس قطبی وحشی کولاک ابدی که در مناطق Glacial پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	23	Sylora
enemy_arcane_103	Arcane	توهم نوری اسرار باستانی	rank_sss	{"gold_max": 1500, "gold_min": 150, "possible_drops": ["item_glacial_082"]}	loc_arcane_003	موجودی خطرناک به نام توهم نوری اسرار باستانی که در مناطق Arcane پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	2	Sylora
enemy_abyss_104	Abyss	بلعنده روح سایه‌های سرگردان	rank_e	{"gold_max": 100, "gold_min": 10, "possible_drops": ["item_arcane_103"]}	loc_abyss_004	موجودی خطرناک به نام بلعنده روح سایه‌های سرگردان که در مناطق Abyss پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	15	Sylora
enemy_volcanic_105	Volcanic	دیو گدازه سنگ جهنمی	rank_d	{"gold_max": 150, "gold_min": 15, "possible_drops": ["item_glacial_058"]}	loc_volcanic_005	موجودی خطرناک به نام دیو گدازه سنگ جهنمی که در مناطق Volcanic پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	55	Sylora
enemy_glacial_106	Glacial	گرگ کولاک سرمای استخوان‌سوز	rank_c	{"gold_max": 220, "gold_min": 22, "possible_drops": ["item_abyss_060"]}	loc_glacial_006	موجودی خطرناک به نام گرگ کولاک سرمای استخوان‌سوز که در مناطق Glacial پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	34	Sylora
enemy_glacial_154	Glacial	غول یخی بلورهای جادویی	rank_c	{"gold_max": 220, "gold_min": 22, "possible_drops": ["item_glacial_018"]}	loc_glacial_054	موجودی خطرناک به نام غول یخی بلورهای جادویی که در مناطق Glacial پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	29	Sylora
enemy_arcane_107	Arcane	جادوگر مرتد انرژی‌های کیهانی	rank_b	{"gold_max": 300, "gold_min": 30, "possible_drops": ["item_volcanic_101"]}	loc_arcane_007	موجودی خطرناک به نام جادوگر مرتد انرژی‌های کیهانی که در مناطق Arcane پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	89	Sylora
enemy_abyss_108	Abyss	بلعنده روح سایه‌های سرگردان	rank_a	{"gold_max": 450, "gold_min": 45, "possible_drops": ["item_volcanic_117"]}	loc_abyss_008	موجودی خطرناک به نام بلعنده روح سایه‌های سرگردان که در مناطق Abyss پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	49	Sylora
enemy_volcanic_109	Volcanic	سگ دوزخی آتشفشان	rank_s	{"gold_max": 650, "gold_min": 65, "possible_drops": ["item_arcane_019"]}	loc_volcanic_009	موجودی خطرناک به نام سگ دوزخی آتشفشان که در مناطق Volcanic پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	87	Sylora
enemy_glacial_110	Glacial	خرس قطبی وحشی یخبندان شمالی	rank_ss	{"gold_max": 900, "gold_min": 90, "possible_drops": ["item_glacial_090"]}	loc_glacial_010	موجودی خطرناک به نام خرس قطبی وحشی یخبندان شمالی که در مناطق Glacial پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	53	Sylora
enemy_arcane_111	Arcane	نگهبان ارگ اسرار باستانی	rank_sss	{"gold_max": 1500, "gold_min": 150, "possible_drops": ["item_glacial_066"]}	loc_arcane_011	موجودی خطرناک به نام نگهبان ارگ اسرار باستانی که در مناطق Arcane پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	64	Sylora
enemy_abyss_112	Abyss	هیولای گنداب ظلمت	rank_e	{"gold_max": 100, "gold_min": 10, "possible_drops": ["item_glacial_142"]}	loc_abyss_012	موجودی خطرناک به نام هیولای گنداب ظلمت که در مناطق Abyss پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	69	Sylora
enemy_volcanic_113	Volcanic	عنصر آتش آتشفشان	rank_d	{"gold_max": 150, "gold_min": 15, "possible_drops": ["item_abyss_056"]}	loc_volcanic_013	موجودی خطرناک به نام عنصر آتش آتشفشان که در مناطق Volcanic پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	3	Sylora
enemy_glacial_114	Glacial	غول یخی زمستان تاریک	rank_c	{"gold_max": 220, "gold_min": 22, "possible_drops": ["item_arcane_059"]}	loc_glacial_014	موجودی خطرناک به نام غول یخی زمستان تاریک که در مناطق Glacial پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	33	Sylora
enemy_arcane_115	Arcane	عنصر مانا انرژی‌های کیهانی	rank_b	{"gold_max": 300, "gold_min": 30, "possible_drops": ["item_abyss_028"]}	loc_arcane_015	موجودی خطرناک به نام عنصر مانا انرژی‌های کیهانی که در مناطق Arcane پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	13	Sylora
enemy_abyss_116	Abyss	هیولای گنداب ظلمت	rank_a	{"gold_max": 450, "gold_min": 45, "possible_drops": ["item_volcanic_145"]}	loc_abyss_016	موجودی خطرناک به نام هیولای گنداب ظلمت که در مناطق Abyss پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	15	Sylora
enemy_volcanic_117	Volcanic	دیو گدازه آتش ابدی	rank_s	{"gold_max": 650, "gold_min": 65, "possible_drops": ["item_abyss_036"]}	loc_volcanic_017	موجودی خطرناک به نام دیو گدازه آتش ابدی که در مناطق Volcanic پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	90	Sylora
enemy_glacial_118	Glacial	گرگ کولاک بلورهای جادویی	rank_ss	{"gold_max": 900, "gold_min": 90, "possible_drops": ["item_volcanic_045"]}	loc_glacial_018	موجودی خطرناک به نام گرگ کولاک بلورهای جادویی که در مناطق Glacial پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	46	Sylora
enemy_arcane_119	Arcane	کتاب جادویی سرگردان مانای سرکش	rank_sss	{"gold_max": 1500, "gold_min": 150, "possible_drops": ["item_glacial_142"]}	loc_arcane_019	موجودی خطرناک به نام کتاب جادویی سرگردان مانای سرکش که در مناطق Arcane پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	5	Sylora
enemy_abyss_120	Abyss	بلعنده روح خلاء	rank_e	{"gold_max": 100, "gold_min": 10, "possible_drops": ["item_abyss_112"]}	loc_abyss_020	موجودی خطرناک به نام بلعنده روح خلاء که در مناطق Abyss پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	61	Sylora
enemy_volcanic_121	Volcanic	دیو گدازه سنگ جهنمی	rank_d	{"gold_max": 150, "gold_min": 15, "possible_drops": ["item_abyss_056"]}	loc_volcanic_021	موجودی خطرناک به نام دیو گدازه سنگ جهنمی که در مناطق Volcanic پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	87	Sylora
enemy_glacial_122	Glacial	گرگ کولاک کولاک ابدی	rank_c	{"gold_max": 220, "gold_min": 22, "possible_drops": ["item_abyss_064"]}	loc_glacial_022	موجودی خطرناک به نام گرگ کولاک کولاک ابدی که در مناطق Glacial پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	26	Sylora
enemy_arcane_123	Arcane	نگهبان ارگ ستاره‌شناسان	rank_b	{"gold_max": 300, "gold_min": 30, "possible_drops": ["item_glacial_142"]}	loc_arcane_023	موجودی خطرناک به نام نگهبان ارگ ستاره‌شناسان که در مناطق Arcane پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	99	Sylora
enemy_abyss_124	Abyss	شبح خلاء خلاء	rank_a	{"gold_max": 450, "gold_min": 45, "possible_drops": ["item_glacial_086"]}	loc_abyss_024	موجودی خطرناک به نام شبح خلاء خلاء که در مناطق Abyss پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	52	Sylora
enemy_volcanic_125	Volcanic	شکارچی خاکستر سنگ جهنمی	rank_s	{"gold_max": 650, "gold_min": 65, "possible_drops": ["item_abyss_140"]}	loc_volcanic_025	موجودی خطرناک به نام شکارچی خاکستر سنگ جهنمی که در مناطق Volcanic پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	45	Sylora
enemy_glacial_126	Glacial	گرگ کولاک زمستان تاریک	rank_ss	{"gold_max": 900, "gold_min": 90, "possible_drops": ["item_abyss_108"]}	loc_glacial_026	موجودی خطرناک به نام گرگ کولاک زمستان تاریک که در مناطق Glacial پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	54	Sylora
enemy_arcane_127	Arcane	عنصر مانا اسرار باستانی	rank_sss	{"gold_max": 1500, "gold_min": 150, "possible_drops": ["item_glacial_006"]}	loc_arcane_027	موجودی خطرناک به نام عنصر مانا اسرار باستانی که در مناطق Arcane پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	70	Sylora
enemy_abyss_128	Abyss	خزنده سایه ظلمت	rank_e	{"gold_max": 100, "gold_min": 10, "possible_drops": ["item_arcane_131"]}	loc_abyss_028	موجودی خطرناک به نام خزنده سایه ظلمت که در مناطق Abyss پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	71	Sylora
enemy_volcanic_129	Volcanic	سگ دوزخی آتش ابدی	rank_d	{"gold_max": 150, "gold_min": 15, "possible_drops": ["item_glacial_142"]}	loc_volcanic_029	موجودی خطرناک به نام سگ دوزخی آتش ابدی که در مناطق Volcanic پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	82	Sylora
enemy_glacial_130	Glacial	گرگ کولاک یخبندان شمالی	rank_c	{"gold_max": 220, "gold_min": 22, "possible_drops": ["item_glacial_122"]}	loc_glacial_030	موجودی خطرناک به نام گرگ کولاک یخبندان شمالی که در مناطق Glacial پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	88	Sylora
enemy_arcane_131	Arcane	کتاب جادویی سرگردان مانای سرکش	rank_b	{"gold_max": 300, "gold_min": 30, "possible_drops": ["item_glacial_030"]}	loc_arcane_031	موجودی خطرناک به نام کتاب جادویی سرگردان مانای سرکش که در مناطق Arcane پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	3	Sylora
enemy_abyss_132	Abyss	هیولای گنداب مرگ ابدی	rank_a	{"gold_max": 450, "gold_min": 45, "possible_drops": ["item_arcane_019"]}	loc_abyss_032	موجودی خطرناک به نام هیولای گنداب مرگ ابدی که در مناطق Abyss پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	40	Sylora
enemy_volcanic_133	Volcanic	سگ دوزخی سنگ جهنمی	rank_s	{"gold_max": 650, "gold_min": 65, "possible_drops": ["item_abyss_128"]}	loc_volcanic_033	موجودی خطرناک به نام سگ دوزخی سنگ جهنمی که در مناطق Volcanic پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	42	Sylora
enemy_glacial_134	Glacial	نگهبان بلورین یخبندان شمالی	rank_ss	{"gold_max": 900, "gold_min": 90, "possible_drops": ["item_volcanic_117"]}	loc_glacial_034	موجودی خطرناک به نام نگهبان بلورین یخبندان شمالی که در مناطق Glacial پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	87	Sylora
enemy_arcane_135	Arcane	توهم نوری جادوی کهن	rank_sss	{"gold_max": 1500, "gold_min": 150, "possible_drops": ["item_arcane_051"]}	loc_arcane_035	موجودی خطرناک به نام توهم نوری جادوی کهن که در مناطق Arcane پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	46	Sylora
enemy_abyss_136	Abyss	نگهبان تاریکی سایه‌های سرگردان	rank_e	{"gold_max": 100, "gold_min": 10, "possible_drops": ["item_abyss_068"]}	loc_abyss_036	موجودی خطرناک به نام نگهبان تاریکی سایه‌های سرگردان که در مناطق Abyss پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	31	Sylora
enemy_volcanic_137	Volcanic	اژدهای خفته خاکستر سرخ	rank_d	{"gold_max": 150, "gold_min": 15, "possible_drops": ["item_abyss_120"]}	loc_volcanic_037	موجودی خطرناک به نام اژدهای خفته خاکستر سرخ که در مناطق Volcanic پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	62	Sylora
enemy_glacial_138	Glacial	گرگ کولاک سرمای استخوان‌سوز	rank_c	{"gold_max": 220, "gold_min": 22, "possible_drops": ["item_abyss_012"]}	loc_glacial_038	موجودی خطرناک به نام گرگ کولاک سرمای استخوان‌سوز که در مناطق Glacial پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	57	Sylora
enemy_arcane_139	Arcane	نگهبان ارگ ستاره‌شناسان	rank_b	{"gold_max": 300, "gold_min": 30, "possible_drops": ["item_abyss_072"]}	loc_arcane_039	موجودی خطرناک به نام نگهبان ارگ ستاره‌شناسان که در مناطق Arcane پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	61	Sylora
enemy_abyss_140	Abyss	هیولای گنداب ظلمت	rank_a	{"gold_max": 450, "gold_min": 45, "possible_drops": ["item_abyss_144"]}	loc_abyss_040	موجودی خطرناک به نام هیولای گنداب ظلمت که در مناطق Abyss پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	3	Sylora
enemy_volcanic_141	Volcanic	عنصر آتش آتش ابدی	rank_s	{"gold_max": 650, "gold_min": 65, "possible_drops": ["item_volcanic_073"]}	loc_volcanic_041	موجودی خطرناک به نام عنصر آتش آتش ابدی که در مناطق Volcanic پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	40	Sylora
enemy_glacial_142	Glacial	شبح منجمد یخبندان شمالی	rank_ss	{"gold_max": 900, "gold_min": 90, "possible_drops": ["item_arcane_099"]}	loc_glacial_042	موجودی خطرناک به نام شبح منجمد یخبندان شمالی که در مناطق Glacial پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	99	Sylora
enemy_arcane_143	Arcane	جادوگر مرتد اسرار باستانی	rank_sss	{"gold_max": 1500, "gold_min": 150, "possible_drops": ["item_volcanic_141"]}	loc_arcane_043	موجودی خطرناک به نام جادوگر مرتد اسرار باستانی که در مناطق Arcane پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	46	Sylora
enemy_abyss_144	Abyss	هیولای گنداب فاسد شده	rank_e	{"gold_max": 100, "gold_min": 10, "possible_drops": ["item_volcanic_065"]}	loc_abyss_044	موجودی خطرناک به نام هیولای گنداب فاسد شده که در مناطق Abyss پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	97	Sylora
enemy_volcanic_145	Volcanic	شکارچی خاکستر گدازه مذاب	rank_d	{"gold_max": 150, "gold_min": 15, "possible_drops": ["item_arcane_107"]}	loc_volcanic_045	موجودی خطرناک به نام شکارچی خاکستر گدازه مذاب که در مناطق Volcanic پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	69	Sylora
enemy_glacial_146	Glacial	خرس قطبی وحشی کولاک ابدی	rank_c	{"gold_max": 220, "gold_min": 22, "possible_drops": ["item_abyss_016"]}	loc_glacial_046	موجودی خطرناک به نام خرس قطبی وحشی کولاک ابدی که در مناطق Glacial پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	26	Sylora
enemy_arcane_147	Arcane	عنصر مانا انرژی‌های کیهانی	rank_b	{"gold_max": 300, "gold_min": 30, "possible_drops": ["item_arcane_127"]}	loc_arcane_047	موجودی خطرناک به نام عنصر مانا انرژی‌های کیهانی که در مناطق Arcane پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	95	Sylora
enemy_abyss_148	Abyss	هیولای گنداب خلاء	rank_a	{"gold_max": 450, "gold_min": 45, "possible_drops": ["item_volcanic_097"]}	loc_abyss_048	موجودی خطرناک به نام هیولای گنداب خلاء که در مناطق Abyss پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	52	Sylora
enemy_volcanic_149	Volcanic	عنصر آتش خاکستر سرخ	rank_s	{"gold_max": 650, "gold_min": 65, "possible_drops": ["item_volcanic_133"]}	loc_volcanic_049	موجودی خطرناک به نام عنصر آتش خاکستر سرخ که در مناطق Volcanic پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	9	Sylora
enemy_glacial_150	Glacial	غول یخی زمستان تاریک	rank_ss	{"gold_max": 900, "gold_min": 90, "possible_drops": ["item_arcane_135"]}	loc_glacial_050	موجودی خطرناک به نام غول یخی زمستان تاریک که در مناطق Glacial پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	41	Sylora
enemy_arcane_151	Arcane	توهم نوری ستاره‌شناسان	rank_sss	{"gold_max": 1500, "gold_min": 150, "possible_drops": ["item_glacial_002"]}	loc_arcane_051	موجودی خطرناک به نام توهم نوری ستاره‌شناسان که در مناطق Arcane پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	58	Sylora
enemy_abyss_152	Abyss	شبح خلاء ظلمت	rank_e	{"gold_max": 100, "gold_min": 10, "possible_drops": ["item_arcane_023"]}	loc_abyss_052	موجودی خطرناک به نام شبح خلاء ظلمت که در مناطق Abyss پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	34	Sylora
enemy_volcanic_153	Volcanic	شکارچی خاکستر گدازه مذاب	rank_d	{"gold_max": 150, "gold_min": 15, "possible_drops": ["item_abyss_128"]}	loc_volcanic_053	موجودی خطرناک به نام شکارچی خاکستر گدازه مذاب که در مناطق Volcanic پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	94	Sylora
enemy_arcane_155	Arcane	جادوگر مرتد ستاره‌شناسان	rank_b	{"gold_max": 300, "gold_min": 30, "possible_drops": ["item_volcanic_085"]}	loc_arcane_055	موجودی خطرناک به نام جادوگر مرتد ستاره‌شناسان که در مناطق Arcane پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	80	Sylora
enemy_abyss_156	Abyss	نگهبان تاریکی ظلمت	rank_a	{"gold_max": 450, "gold_min": 45, "possible_drops": ["item_volcanic_065"]}	loc_abyss_056	موجودی خطرناک به نام نگهبان تاریکی ظلمت که در مناطق Abyss پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	18	Sylora
enemy_volcanic_157	Volcanic	سگ دوزخی گدازه مذاب	rank_s	{"gold_max": 650, "gold_min": 65, "possible_drops": ["item_abyss_000"]}	loc_volcanic_057	موجودی خطرناک به نام سگ دوزخی گدازه مذاب که در مناطق Volcanic پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	12	Sylora
enemy_glacial_158	Glacial	گرگ کولاک یخبندان شمالی	rank_ss	{"gold_max": 900, "gold_min": 90, "possible_drops": ["item_volcanic_133"]}	loc_glacial_058	موجودی خطرناک به نام گرگ کولاک یخبندان شمالی که در مناطق Glacial پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	11	Sylora
enemy_arcane_159	Arcane	کتاب جادویی سرگردان انرژی‌های کیهانی	rank_sss	{"gold_max": 1500, "gold_min": 150, "possible_drops": ["item_volcanic_033"]}	loc_arcane_059	موجودی خطرناک به نام کتاب جادویی سرگردان انرژی‌های کیهانی که در مناطق Arcane پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	32	Sylora
enemy_abyss_160	Abyss	هیولای گنداب خلاء	rank_e	{"gold_max": 100, "gold_min": 10, "possible_drops": ["item_abyss_000"]}	loc_abyss_060	موجودی خطرناک به نام هیولای گنداب خلاء که در مناطق Abyss پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	84	Sylora
enemy_volcanic_161	Volcanic	شکارچی خاکستر آتشفشان	rank_d	{"gold_max": 150, "gold_min": 15, "possible_drops": ["item_abyss_064"]}	loc_volcanic_061	موجودی خطرناک به نام شکارچی خاکستر آتشفشان که در مناطق Volcanic پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	51	Sylora
enemy_glacial_162	Glacial	شبح منجمد کولاک ابدی	rank_c	{"gold_max": 220, "gold_min": 22, "possible_drops": ["item_arcane_091"]}	loc_glacial_062	موجودی خطرناک به نام شبح منجمد کولاک ابدی که در مناطق Glacial پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	95	Sylora
enemy_arcane_163	Arcane	جادوگر مرتد انرژی‌های کیهانی	rank_b	{"gold_max": 300, "gold_min": 30, "possible_drops": ["item_arcane_147"]}	loc_arcane_063	موجودی خطرناک به نام جادوگر مرتد انرژی‌های کیهانی که در مناطق Arcane پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	87	Sylora
enemy_abyss_164	Abyss	خزنده سایه فاسد شده	rank_a	{"gold_max": 450, "gold_min": 45, "possible_drops": ["item_volcanic_093"]}	loc_abyss_064	موجودی خطرناک به نام خزنده سایه فاسد شده که در مناطق Abyss پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	97	Sylora
enemy_volcanic_165	Volcanic	شکارچی خاکستر آتش ابدی	rank_s	{"gold_max": 650, "gold_min": 65, "possible_drops": ["item_arcane_087"]}	loc_volcanic_065	موجودی خطرناک به نام شکارچی خاکستر آتش ابدی که در مناطق Volcanic پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	11	Sylora
enemy_glacial_166	Glacial	گرگ کولاک سرمای استخوان‌سوز	rank_ss	{"gold_max": 900, "gold_min": 90, "possible_drops": ["item_volcanic_137"]}	loc_glacial_066	موجودی خطرناک به نام گرگ کولاک سرمای استخوان‌سوز که در مناطق Glacial پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	9	Sylora
enemy_arcane_167	Arcane	عنصر مانا اسرار باستانی	rank_sss	{"gold_max": 1500, "gold_min": 150, "possible_drops": ["item_glacial_030"]}	loc_arcane_067	موجودی خطرناک به نام عنصر مانا اسرار باستانی که در مناطق Arcane پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	59	Sylora
enemy_abyss_168	Abyss	خزنده سایه سایه‌های سرگردان	rank_e	{"gold_max": 100, "gold_min": 10, "possible_drops": ["item_volcanic_001"]}	loc_abyss_068	موجودی خطرناک به نام خزنده سایه سایه‌های سرگردان که در مناطق Abyss پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	87	Sylora
enemy_volcanic_169	Volcanic	شکارچی خاکستر گدازه مذاب	rank_d	{"gold_max": 150, "gold_min": 15, "possible_drops": ["item_abyss_092"]}	loc_volcanic_069	موجودی خطرناک به نام شکارچی خاکستر گدازه مذاب که در مناطق Volcanic پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	33	Sylora
enemy_glacial_170	Glacial	شبح منجمد یخبندان شمالی	rank_c	{"gold_max": 220, "gold_min": 22, "possible_drops": ["item_glacial_086"]}	loc_glacial_070	موجودی خطرناک به نام شبح منجمد یخبندان شمالی که در مناطق Glacial پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	4	Sylora
enemy_arcane_171	Arcane	کتاب جادویی سرگردان مانای سرکش	rank_b	{"gold_max": 300, "gold_min": 30, "possible_drops": ["item_arcane_063"]}	loc_arcane_071	موجودی خطرناک به نام کتاب جادویی سرگردان مانای سرکش که در مناطق Arcane پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	22	Sylora
enemy_abyss_172	Abyss	شبح خلاء سایه‌های سرگردان	rank_a	{"gold_max": 450, "gold_min": 45, "possible_drops": ["item_glacial_002"]}	loc_abyss_072	موجودی خطرناک به نام شبح خلاء سایه‌های سرگردان که در مناطق Abyss پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	69	Sylora
enemy_volcanic_173	Volcanic	اژدهای خفته گدازه مذاب	rank_s	{"gold_max": 650, "gold_min": 65, "possible_drops": ["item_volcanic_101"]}	loc_volcanic_073	موجودی خطرناک به نام اژدهای خفته گدازه مذاب که در مناطق Volcanic پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	56	Sylora
enemy_glacial_174	Glacial	غول یخی زمستان تاریک	rank_ss	{"gold_max": 900, "gold_min": 90, "possible_drops": ["item_arcane_031"]}	loc_glacial_074	موجودی خطرناک به نام غول یخی زمستان تاریک که در مناطق Glacial پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	12	Sylora
enemy_arcane_175	Arcane	نگهبان ارگ ستاره‌شناسان	rank_sss	{"gold_max": 1500, "gold_min": 150, "possible_drops": ["item_volcanic_069"]}	loc_arcane_075	موجودی خطرناک به نام نگهبان ارگ ستاره‌شناسان که در مناطق Arcane پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	73	Sylora
enemy_abyss_176	Abyss	شبح خلاء سایه‌های سرگردان	rank_e	{"gold_max": 100, "gold_min": 10, "possible_drops": ["item_arcane_111"]}	loc_abyss_076	موجودی خطرناک به نام شبح خلاء سایه‌های سرگردان که در مناطق Abyss پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	29	Sylora
enemy_volcanic_177	Volcanic	اژدهای خفته خاکستر سرخ	rank_d	{"gold_max": 150, "gold_min": 15, "possible_drops": ["item_abyss_092"]}	loc_volcanic_077	موجودی خطرناک به نام اژدهای خفته خاکستر سرخ که در مناطق Volcanic پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	81	Sylora
enemy_glacial_178	Glacial	غول یخی زمستان تاریک	rank_c	{"gold_max": 220, "gold_min": 22, "possible_drops": ["item_volcanic_001"]}	loc_glacial_078	موجودی خطرناک به نام غول یخی زمستان تاریک که در مناطق Glacial پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	40	Sylora
enemy_arcane_179	Arcane	توهم نوری ستاره‌شناسان	rank_b	{"gold_max": 300, "gold_min": 30, "possible_drops": ["item_volcanic_025"]}	loc_arcane_079	موجودی خطرناک به نام توهم نوری ستاره‌شناسان که در مناطق Arcane پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	17	Sylora
enemy_abyss_180	Abyss	بلعنده روح ظلمت	rank_a	{"gold_max": 450, "gold_min": 45, "possible_drops": ["item_volcanic_101"]}	loc_abyss_080	موجودی خطرناک به نام بلعنده روح ظلمت که در مناطق Abyss پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	55	Sylora
enemy_volcanic_181	Volcanic	عنصر آتش آتش ابدی	rank_s	{"gold_max": 650, "gold_min": 65, "possible_drops": ["item_volcanic_081"]}	loc_volcanic_081	موجودی خطرناک به نام عنصر آتش آتش ابدی که در مناطق Volcanic پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	61	Sylora
enemy_glacial_182	Glacial	شبح منجمد زمستان تاریک	rank_ss	{"gold_max": 900, "gold_min": 90, "possible_drops": ["item_arcane_039"]}	loc_glacial_082	موجودی خطرناک به نام شبح منجمد زمستان تاریک که در مناطق Glacial پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	2	Sylora
enemy_arcane_183	Arcane	توهم نوری اسرار باستانی	rank_sss	{"gold_max": 1500, "gold_min": 150, "possible_drops": ["item_glacial_014"]}	loc_arcane_083	موجودی خطرناک به نام توهم نوری اسرار باستانی که در مناطق Arcane پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	62	Sylora
enemy_abyss_184	Abyss	هیولای گنداب فاسد شده	rank_e	{"gold_max": 100, "gold_min": 10, "possible_drops": ["item_volcanic_093"]}	loc_abyss_084	موجودی خطرناک به نام هیولای گنداب فاسد شده که در مناطق Abyss پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	94	Sylora
enemy_volcanic_185	Volcanic	عنصر آتش آتش ابدی	rank_d	{"gold_max": 150, "gold_min": 15, "possible_drops": ["item_arcane_075"]}	loc_volcanic_085	موجودی خطرناک به نام عنصر آتش آتش ابدی که در مناطق Volcanic پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	68	Sylora
enemy_glacial_186	Glacial	شبح منجمد سرمای استخوان‌سوز	rank_c	{"gold_max": 220, "gold_min": 22, "possible_drops": ["item_arcane_131"]}	loc_glacial_086	موجودی خطرناک به نام شبح منجمد سرمای استخوان‌سوز که در مناطق Glacial پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	31	Sylora
enemy_arcane_187	Arcane	کتاب جادویی سرگردان ستاره‌شناسان	rank_b	{"gold_max": 300, "gold_min": 30, "possible_drops": ["item_abyss_148"]}	loc_arcane_087	موجودی خطرناک به نام کتاب جادویی سرگردان ستاره‌شناسان که در مناطق Arcane پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	41	Sylora
enemy_abyss_188	Abyss	هیولای گنداب فاسد شده	rank_a	{"gold_max": 450, "gold_min": 45, "possible_drops": ["item_abyss_100"]}	loc_abyss_088	موجودی خطرناک به نام هیولای گنداب فاسد شده که در مناطق Abyss پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	95	Sylora
enemy_volcanic_189	Volcanic	اژدهای خفته خاکستر سرخ	rank_s	{"gold_max": 650, "gold_min": 65, "possible_drops": ["item_volcanic_065"]}	loc_volcanic_089	موجودی خطرناک به نام اژدهای خفته خاکستر سرخ که در مناطق Volcanic پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	74	Sylora
enemy_glacial_190	Glacial	شبح منجمد سرمای استخوان‌سوز	rank_ss	{"gold_max": 900, "gold_min": 90, "possible_drops": ["item_volcanic_069"]}	loc_glacial_090	موجودی خطرناک به نام شبح منجمد سرمای استخوان‌سوز که در مناطق Glacial پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	19	Sylora
enemy_arcane_191	Arcane	جادوگر مرتد انرژی‌های کیهانی	rank_sss	{"gold_max": 1500, "gold_min": 150, "possible_drops": ["item_glacial_030"]}	loc_arcane_091	موجودی خطرناک به نام جادوگر مرتد انرژی‌های کیهانی که در مناطق Arcane پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	57	Sylora
enemy_abyss_192	Abyss	بلعنده روح مرگ ابدی	rank_e	{"gold_max": 100, "gold_min": 10, "possible_drops": ["item_abyss_064"]}	loc_abyss_092	موجودی خطرناک به نام بلعنده روح مرگ ابدی که در مناطق Abyss پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	96	Sylora
enemy_volcanic_193	Volcanic	شکارچی خاکستر سنگ جهنمی	rank_d	{"gold_max": 150, "gold_min": 15, "possible_drops": ["item_abyss_108"]}	loc_volcanic_093	موجودی خطرناک به نام شکارچی خاکستر سنگ جهنمی که در مناطق Volcanic پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	88	Sylora
enemy_glacial_194	Glacial	خرس قطبی وحشی سرمای استخوان‌سوز	rank_c	{"gold_max": 220, "gold_min": 22, "possible_drops": ["item_arcane_119"]}	loc_glacial_094	موجودی خطرناک به نام خرس قطبی وحشی سرمای استخوان‌سوز که در مناطق Glacial پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	11	Sylora
enemy_arcane_195	Arcane	عنصر مانا انرژی‌های کیهانی	rank_b	{"gold_max": 300, "gold_min": 30, "possible_drops": ["item_arcane_079"]}	loc_arcane_095	موجودی خطرناک به نام عنصر مانا انرژی‌های کیهانی که در مناطق Arcane پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	21	Sylora
enemy_abyss_196	Abyss	خزنده سایه مرگ ابدی	rank_a	{"gold_max": 450, "gold_min": 45, "possible_drops": ["item_abyss_036"]}	loc_abyss_096	موجودی خطرناک به نام خزنده سایه مرگ ابدی که در مناطق Abyss پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	30	Sylora
enemy_volcanic_197	Volcanic	عنصر آتش آتشفشان	rank_s	{"gold_max": 650, "gold_min": 65, "possible_drops": ["item_arcane_071"]}	loc_volcanic_097	موجودی خطرناک به نام عنصر آتش آتشفشان که در مناطق Volcanic پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	66	Sylora
enemy_glacial_198	Glacial	گرگ کولاک کولاک ابدی	rank_ss	{"gold_max": 900, "gold_min": 90, "possible_drops": ["item_volcanic_061"]}	loc_glacial_098	موجودی خطرناک به نام گرگ کولاک کولاک ابدی که در مناطق Glacial پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	50	Sylora
enemy_arcane_199	Arcane	جادوگر مرتد جادوی کهن	rank_sss	{"gold_max": 1500, "gold_min": 150, "possible_drops": ["item_arcane_095"]}	loc_arcane_099	موجودی خطرناک به نام جادوگر مرتد جادوی کهن که در مناطق Arcane پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	64	Sylora
enemy_abyss_200	Abyss	خزنده سایه ظلمت	rank_e	{"gold_max": 100, "gold_min": 10, "possible_drops": ["item_abyss_132"]}	loc_abyss_000	موجودی خطرناک به نام خزنده سایه ظلمت که در مناطق Abyss پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	55	Sylora
enemy_volcanic_201	Volcanic	شکارچی خاکستر خاکستر سرخ	rank_d	{"gold_max": 150, "gold_min": 15, "possible_drops": ["item_arcane_119"]}	loc_volcanic_001	موجودی خطرناک به نام شکارچی خاکستر خاکستر سرخ که در مناطق Volcanic پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	28	Sylora
enemy_glacial_202	Glacial	نگهبان بلورین سرمای استخوان‌سوز	rank_c	{"gold_max": 220, "gold_min": 22, "possible_drops": ["item_volcanic_073"]}	loc_glacial_002	موجودی خطرناک به نام نگهبان بلورین سرمای استخوان‌سوز که در مناطق Glacial پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	95	Sylora
enemy_arcane_203	Arcane	عنصر مانا جادوی کهن	rank_b	{"gold_max": 300, "gold_min": 30, "possible_drops": ["item_abyss_004"]}	loc_arcane_003	موجودی خطرناک به نام عنصر مانا جادوی کهن که در مناطق Arcane پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	18	Sylora
enemy_abyss_204	Abyss	خزنده سایه سایه‌های سرگردان	rank_a	{"gold_max": 450, "gold_min": 45, "possible_drops": ["item_glacial_070"]}	loc_abyss_004	موجودی خطرناک به نام خزنده سایه سایه‌های سرگردان که در مناطق Abyss پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	48	Sylora
enemy_volcanic_205	Volcanic	اژدهای خفته خاکستر سرخ	rank_s	{"gold_max": 650, "gold_min": 65, "possible_drops": ["item_arcane_143"]}	loc_volcanic_005	موجودی خطرناک به نام اژدهای خفته خاکستر سرخ که در مناطق Volcanic پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	76	Sylora
enemy_glacial_206	Glacial	گرگ کولاک زمستان تاریک	rank_ss	{"gold_max": 900, "gold_min": 90, "possible_drops": ["item_volcanic_073"]}	loc_glacial_006	موجودی خطرناک به نام گرگ کولاک زمستان تاریک که در مناطق Glacial پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	50	Sylora
enemy_arcane_207	Arcane	عنصر مانا انرژی‌های کیهانی	rank_sss	{"gold_max": 1500, "gold_min": 150, "possible_drops": ["item_arcane_063"]}	loc_arcane_007	موجودی خطرناک به نام عنصر مانا انرژی‌های کیهانی که در مناطق Arcane پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	99	Sylora
enemy_abyss_208	Abyss	شبح خلاء مرگ ابدی	rank_e	{"gold_max": 100, "gold_min": 10, "possible_drops": ["item_volcanic_077"]}	loc_abyss_008	موجودی خطرناک به نام شبح خلاء مرگ ابدی که در مناطق Abyss پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	23	Sylora
enemy_volcanic_209	Volcanic	دیو گدازه آتش ابدی	rank_d	{"gold_max": 150, "gold_min": 15, "possible_drops": ["item_arcane_079"]}	loc_volcanic_009	موجودی خطرناک به نام دیو گدازه آتش ابدی که در مناطق Volcanic پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	47	Sylora
enemy_glacial_210	Glacial	نگهبان بلورین بلورهای جادویی	rank_c	{"gold_max": 220, "gold_min": 22, "possible_drops": ["item_glacial_038"]}	loc_glacial_010	موجودی خطرناک به نام نگهبان بلورین بلورهای جادویی که در مناطق Glacial پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	63	Sylora
enemy_arcane_211	Arcane	نگهبان ارگ اسرار باستانی	rank_b	{"gold_max": 300, "gold_min": 30, "possible_drops": ["item_glacial_070"]}	loc_arcane_011	موجودی خطرناک به نام نگهبان ارگ اسرار باستانی که در مناطق Arcane پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	20	Sylora
enemy_abyss_212	Abyss	بلعنده روح سایه‌های سرگردان	rank_a	{"gold_max": 450, "gold_min": 45, "possible_drops": ["item_glacial_018"]}	loc_abyss_012	موجودی خطرناک به نام بلعنده روح سایه‌های سرگردان که در مناطق Abyss پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	100	Sylora
enemy_volcanic_213	Volcanic	اژدهای خفته آتش ابدی	rank_s	{"gold_max": 650, "gold_min": 65, "possible_drops": ["item_volcanic_129"]}	loc_volcanic_013	موجودی خطرناک به نام اژدهای خفته آتش ابدی که در مناطق Volcanic پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	40	Sylora
enemy_glacial_214	Glacial	نگهبان بلورین کولاک ابدی	rank_ss	{"gold_max": 900, "gold_min": 90, "possible_drops": ["item_arcane_019"]}	loc_glacial_014	موجودی خطرناک به نام نگهبان بلورین کولاک ابدی که در مناطق Glacial پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	87	Sylora
enemy_arcane_215	Arcane	نگهبان ارگ اسرار باستانی	rank_sss	{"gold_max": 1500, "gold_min": 150, "possible_drops": ["item_arcane_059"]}	loc_arcane_015	موجودی خطرناک به نام نگهبان ارگ اسرار باستانی که در مناطق Arcane پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	35	Sylora
enemy_abyss_216	Abyss	هیولای گنداب فاسد شده	rank_e	{"gold_max": 100, "gold_min": 10, "possible_drops": ["item_volcanic_001"]}	loc_abyss_016	موجودی خطرناک به نام هیولای گنداب فاسد شده که در مناطق Abyss پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	9	Sylora
enemy_volcanic_217	Volcanic	عنصر آتش آتشفشان	rank_d	{"gold_max": 150, "gold_min": 15, "possible_drops": ["item_volcanic_101"]}	loc_volcanic_017	موجودی خطرناک به نام عنصر آتش آتشفشان که در مناطق Volcanic پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	55	Sylora
enemy_glacial_218	Glacial	گرگ کولاک زمستان تاریک	rank_c	{"gold_max": 220, "gold_min": 22, "possible_drops": ["item_glacial_062"]}	loc_glacial_018	موجودی خطرناک به نام گرگ کولاک زمستان تاریک که در مناطق Glacial پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	25	Sylora
enemy_arcane_219	Arcane	توهم نوری جادوی کهن	rank_b	{"gold_max": 300, "gold_min": 30, "possible_drops": ["item_abyss_060"]}	loc_arcane_019	موجودی خطرناک به نام توهم نوری جادوی کهن که در مناطق Arcane پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	61	Sylora
enemy_abyss_220	Abyss	شبح خلاء مرگ ابدی	rank_a	{"gold_max": 450, "gold_min": 45, "possible_drops": ["item_abyss_112"]}	loc_abyss_020	موجودی خطرناک به نام شبح خلاء مرگ ابدی که در مناطق Abyss پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	91	Sylora
enemy_volcanic_221	Volcanic	اژدهای خفته سنگ جهنمی	rank_s	{"gold_max": 650, "gold_min": 65, "possible_drops": ["item_volcanic_085"]}	loc_volcanic_021	موجودی خطرناک به نام اژدهای خفته سنگ جهنمی که در مناطق Volcanic پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	83	Sylora
enemy_glacial_222	Glacial	نگهبان بلورین زمستان تاریک	rank_ss	{"gold_max": 900, "gold_min": 90, "possible_drops": ["item_volcanic_045"]}	loc_glacial_022	موجودی خطرناک به نام نگهبان بلورین زمستان تاریک که در مناطق Glacial پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	42	Sylora
enemy_arcane_223	Arcane	جادوگر مرتد ستاره‌شناسان	rank_sss	{"gold_max": 1500, "gold_min": 150, "possible_drops": ["item_abyss_092"]}	loc_arcane_023	موجودی خطرناک به نام جادوگر مرتد ستاره‌شناسان که در مناطق Arcane پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	15	Sylora
enemy_abyss_224	Abyss	بلعنده روح خلاء	rank_e	{"gold_max": 100, "gold_min": 10, "possible_drops": ["item_arcane_111"]}	loc_abyss_024	موجودی خطرناک به نام بلعنده روح خلاء که در مناطق Abyss پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	44	Sylora
enemy_volcanic_225	Volcanic	دیو گدازه آتشفشان	rank_d	{"gold_max": 150, "gold_min": 15, "possible_drops": ["item_arcane_007"]}	loc_volcanic_025	موجودی خطرناک به نام دیو گدازه آتشفشان که در مناطق Volcanic پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	47	Sylora
enemy_glacial_226	Glacial	خرس قطبی وحشی زمستان تاریک	rank_c	{"gold_max": 220, "gold_min": 22, "possible_drops": ["item_glacial_042"]}	loc_glacial_026	موجودی خطرناک به نام خرس قطبی وحشی زمستان تاریک که در مناطق Glacial پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	54	Sylora
enemy_arcane_227	Arcane	کتاب جادویی سرگردان ستاره‌شناسان	rank_b	{"gold_max": 300, "gold_min": 30, "possible_drops": ["item_arcane_099"]}	loc_arcane_027	موجودی خطرناک به نام کتاب جادویی سرگردان ستاره‌شناسان که در مناطق Arcane پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	35	Sylora
enemy_abyss_228	Abyss	بلعنده روح فاسد شده	rank_a	{"gold_max": 450, "gold_min": 45, "possible_drops": ["item_volcanic_089"]}	loc_abyss_028	موجودی خطرناک به نام بلعنده روح فاسد شده که در مناطق Abyss پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	79	Sylora
enemy_volcanic_229	Volcanic	دیو گدازه گدازه مذاب	rank_s	{"gold_max": 650, "gold_min": 65, "possible_drops": ["item_abyss_048"]}	loc_volcanic_029	موجودی خطرناک به نام دیو گدازه گدازه مذاب که در مناطق Volcanic پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	89	Sylora
enemy_glacial_230	Glacial	شبح منجمد زمستان تاریک	rank_ss	{"gold_max": 900, "gold_min": 90, "possible_drops": ["item_arcane_059"]}	loc_glacial_030	موجودی خطرناک به نام شبح منجمد زمستان تاریک که در مناطق Glacial پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	56	Sylora
enemy_arcane_231	Arcane	عنصر مانا جادوی کهن	rank_sss	{"gold_max": 1500, "gold_min": 150, "possible_drops": ["item_volcanic_097"]}	loc_arcane_031	موجودی خطرناک به نام عنصر مانا جادوی کهن که در مناطق Arcane پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	18	Sylora
enemy_abyss_232	Abyss	بلعنده روح خلاء	rank_e	{"gold_max": 100, "gold_min": 10, "possible_drops": ["item_glacial_050"]}	loc_abyss_032	موجودی خطرناک به نام بلعنده روح خلاء که در مناطق Abyss پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	6	Sylora
enemy_volcanic_233	Volcanic	اژدهای خفته سنگ جهنمی	rank_d	{"gold_max": 150, "gold_min": 15, "possible_drops": ["item_abyss_116"]}	loc_volcanic_033	موجودی خطرناک به نام اژدهای خفته سنگ جهنمی که در مناطق Volcanic پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	13	Sylora
enemy_glacial_234	Glacial	گرگ کولاک زمستان تاریک	rank_c	{"gold_max": 220, "gold_min": 22, "possible_drops": ["item_volcanic_025"]}	loc_glacial_034	موجودی خطرناک به نام گرگ کولاک زمستان تاریک که در مناطق Glacial پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	26	Sylora
enemy_arcane_235	Arcane	توهم نوری اسرار باستانی	rank_b	{"gold_max": 300, "gold_min": 30, "possible_drops": ["item_volcanic_125"]}	loc_arcane_035	موجودی خطرناک به نام توهم نوری اسرار باستانی که در مناطق Arcane پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	81	Sylora
enemy_abyss_236	Abyss	شبح خلاء فاسد شده	rank_a	{"gold_max": 450, "gold_min": 45, "possible_drops": ["item_glacial_054"]}	loc_abyss_036	موجودی خطرناک به نام شبح خلاء فاسد شده که در مناطق Abyss پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	53	Sylora
enemy_volcanic_237	Volcanic	دیو گدازه گدازه مذاب	rank_s	{"gold_max": 650, "gold_min": 65, "possible_drops": ["item_arcane_087"]}	loc_volcanic_037	موجودی خطرناک به نام دیو گدازه گدازه مذاب که در مناطق Volcanic پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	92	Sylora
enemy_glacial_238	Glacial	نگهبان بلورین بلورهای جادویی	rank_ss	{"gold_max": 900, "gold_min": 90, "possible_drops": ["item_arcane_083"]}	loc_glacial_038	موجودی خطرناک به نام نگهبان بلورین بلورهای جادویی که در مناطق Glacial پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	44	Sylora
enemy_arcane_239	Arcane	عنصر مانا اسرار باستانی	rank_sss	{"gold_max": 1500, "gold_min": 150, "possible_drops": ["item_glacial_110"]}	loc_arcane_039	موجودی خطرناک به نام عنصر مانا اسرار باستانی که در مناطق Arcane پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	22	Sylora
enemy_abyss_240	Abyss	هیولای گنداب فاسد شده	rank_e	{"gold_max": 100, "gold_min": 10, "possible_drops": ["item_arcane_007"]}	loc_abyss_040	موجودی خطرناک به نام هیولای گنداب فاسد شده که در مناطق Abyss پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	28	Sylora
enemy_volcanic_241	Volcanic	دیو گدازه گدازه مذاب	rank_d	{"gold_max": 150, "gold_min": 15, "possible_drops": ["item_abyss_028"]}	loc_volcanic_041	موجودی خطرناک به نام دیو گدازه گدازه مذاب که در مناطق Volcanic پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	56	Sylora
enemy_glacial_242	Glacial	نگهبان بلورین یخبندان شمالی	rank_c	{"gold_max": 220, "gold_min": 22, "possible_drops": ["item_glacial_126"]}	loc_glacial_042	موجودی خطرناک به نام نگهبان بلورین یخبندان شمالی که در مناطق Glacial پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	49	Sylora
enemy_arcane_243	Arcane	کتاب جادویی سرگردان مانای سرکش	rank_b	{"gold_max": 300, "gold_min": 30, "possible_drops": ["item_abyss_048"]}	loc_arcane_043	موجودی خطرناک به نام کتاب جادویی سرگردان مانای سرکش که در مناطق Arcane پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	13	Sylora
enemy_abyss_244	Abyss	نگهبان تاریکی سایه‌های سرگردان	rank_a	{"gold_max": 450, "gold_min": 45, "possible_drops": ["item_arcane_071"]}	loc_abyss_044	موجودی خطرناک به نام نگهبان تاریکی سایه‌های سرگردان که در مناطق Abyss پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	13	Sylora
enemy_volcanic_245	Volcanic	اژدهای خفته گدازه مذاب	rank_s	{"gold_max": 650, "gold_min": 65, "possible_drops": ["item_abyss_120"]}	loc_volcanic_045	موجودی خطرناک به نام اژدهای خفته گدازه مذاب که در مناطق Volcanic پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	16	Sylora
enemy_glacial_246	Glacial	گرگ کولاک زمستان تاریک	rank_ss	{"gold_max": 900, "gold_min": 90, "possible_drops": ["item_volcanic_025"]}	loc_glacial_046	موجودی خطرناک به نام گرگ کولاک زمستان تاریک که در مناطق Glacial پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	57	Sylora
enemy_arcane_247	Arcane	عنصر مانا اسرار باستانی	rank_sss	{"gold_max": 1500, "gold_min": 150, "possible_drops": ["item_glacial_078"]}	loc_arcane_047	موجودی خطرناک به نام عنصر مانا اسرار باستانی که در مناطق Arcane پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	29	Sylora
enemy_abyss_248	Abyss	خزنده سایه خلاء	rank_e	{"gold_max": 100, "gold_min": 10, "possible_drops": ["item_glacial_042"]}	loc_abyss_048	موجودی خطرناک به نام خزنده سایه خلاء که در مناطق Abyss پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	63	Sylora
enemy_volcanic_249	Volcanic	شکارچی خاکستر سنگ جهنمی	rank_d	{"gold_max": 150, "gold_min": 15, "possible_drops": ["item_glacial_110"]}	loc_volcanic_049	موجودی خطرناک به نام شکارچی خاکستر سنگ جهنمی که در مناطق Volcanic پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	93	Sylora
enemy_glacial_250	Glacial	شبح منجمد بلورهای جادویی	rank_c	{"gold_max": 220, "gold_min": 22, "possible_drops": ["item_abyss_064"]}	loc_glacial_050	موجودی خطرناک به نام شبح منجمد بلورهای جادویی که در مناطق Glacial پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	47	Sylora
enemy_arcane_251	Arcane	توهم نوری مانای سرکش	rank_b	{"gold_max": 300, "gold_min": 30, "possible_drops": ["item_arcane_055"]}	loc_arcane_051	موجودی خطرناک به نام توهم نوری مانای سرکش که در مناطق Arcane پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	12	Sylora
enemy_abyss_252	Abyss	خزنده سایه خلاء	rank_a	{"gold_max": 450, "gold_min": 45, "possible_drops": ["item_arcane_067"]}	loc_abyss_052	موجودی خطرناک به نام خزنده سایه خلاء که در مناطق Abyss پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	97	Sylora
enemy_volcanic_253	Volcanic	عنصر آتش خاکستر سرخ	rank_s	{"gold_max": 650, "gold_min": 65, "possible_drops": ["item_volcanic_141"]}	loc_volcanic_053	موجودی خطرناک به نام عنصر آتش خاکستر سرخ که در مناطق Volcanic پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	18	Sylora
enemy_glacial_254	Glacial	نگهبان بلورین بلورهای جادویی	rank_ss	{"gold_max": 900, "gold_min": 90, "possible_drops": ["item_abyss_088"]}	loc_glacial_054	موجودی خطرناک به نام نگهبان بلورین بلورهای جادویی که در مناطق Glacial پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	28	Sylora
enemy_arcane_255	Arcane	جادوگر مرتد جادوی کهن	rank_sss	{"gold_max": 1500, "gold_min": 150, "possible_drops": ["item_abyss_028"]}	loc_arcane_055	موجودی خطرناک به نام جادوگر مرتد جادوی کهن که در مناطق Arcane پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	89	Sylora
enemy_abyss_256	Abyss	بلعنده روح مرگ ابدی	rank_e	{"gold_max": 100, "gold_min": 10, "possible_drops": ["item_arcane_019"]}	loc_abyss_056	موجودی خطرناک به نام بلعنده روح مرگ ابدی که در مناطق Abyss پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	73	Sylora
enemy_volcanic_257	Volcanic	دیو گدازه سنگ جهنمی	rank_d	{"gold_max": 150, "gold_min": 15, "possible_drops": ["item_arcane_035"]}	loc_volcanic_057	موجودی خطرناک به نام دیو گدازه سنگ جهنمی که در مناطق Volcanic پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	15	Sylora
enemy_glacial_258	Glacial	غول یخی یخبندان شمالی	rank_c	{"gold_max": 220, "gold_min": 22, "possible_drops": ["item_volcanic_105"]}	loc_glacial_058	موجودی خطرناک به نام غول یخی یخبندان شمالی که در مناطق Glacial پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	62	Sylora
enemy_arcane_259	Arcane	توهم نوری انرژی‌های کیهانی	rank_b	{"gold_max": 300, "gold_min": 30, "possible_drops": ["item_glacial_038"]}	loc_arcane_059	موجودی خطرناک به نام توهم نوری انرژی‌های کیهانی که در مناطق Arcane پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	18	Sylora
enemy_abyss_260	Abyss	شبح خلاء خلاء	rank_a	{"gold_max": 450, "gold_min": 45, "possible_drops": ["item_arcane_107"]}	loc_abyss_060	موجودی خطرناک به نام شبح خلاء خلاء که در مناطق Abyss پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	24	Sylora
enemy_volcanic_261	Volcanic	شکارچی خاکستر آتشفشان	rank_s	{"gold_max": 650, "gold_min": 65, "possible_drops": ["item_glacial_106"]}	loc_volcanic_061	موجودی خطرناک به نام شکارچی خاکستر آتشفشان که در مناطق Volcanic پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	30	Sylora
enemy_glacial_262	Glacial	نگهبان بلورین زمستان تاریک	rank_ss	{"gold_max": 900, "gold_min": 90, "possible_drops": ["item_arcane_003"]}	loc_glacial_062	موجودی خطرناک به نام نگهبان بلورین زمستان تاریک که در مناطق Glacial پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	29	Sylora
enemy_arcane_263	Arcane	توهم نوری ستاره‌شناسان	rank_sss	{"gold_max": 1500, "gold_min": 150, "possible_drops": ["item_volcanic_141"]}	loc_arcane_063	موجودی خطرناک به نام توهم نوری ستاره‌شناسان که در مناطق Arcane پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	82	Sylora
enemy_abyss_264	Abyss	نگهبان تاریکی فاسد شده	rank_e	{"gold_max": 100, "gold_min": 10, "possible_drops": ["item_arcane_015"]}	loc_abyss_064	موجودی خطرناک به نام نگهبان تاریکی فاسد شده که در مناطق Abyss پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	54	Sylora
enemy_volcanic_265	Volcanic	دیو گدازه خاکستر سرخ	rank_d	{"gold_max": 150, "gold_min": 15, "possible_drops": ["item_volcanic_137"]}	loc_volcanic_065	موجودی خطرناک به نام دیو گدازه خاکستر سرخ که در مناطق Volcanic پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	90	Sylora
enemy_glacial_266	Glacial	غول یخی یخبندان شمالی	rank_c	{"gold_max": 220, "gold_min": 22, "possible_drops": ["item_volcanic_037"]}	loc_glacial_066	موجودی خطرناک به نام غول یخی یخبندان شمالی که در مناطق Glacial پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	17	Sylora
enemy_arcane_267	Arcane	توهم نوری انرژی‌های کیهانی	rank_b	{"gold_max": 300, "gold_min": 30, "possible_drops": ["item_abyss_120"]}	loc_arcane_067	موجودی خطرناک به نام توهم نوری انرژی‌های کیهانی که در مناطق Arcane پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	75	Sylora
enemy_abyss_268	Abyss	بلعنده روح خلاء	rank_a	{"gold_max": 450, "gold_min": 45, "possible_drops": ["item_abyss_044"]}	loc_abyss_068	موجودی خطرناک به نام بلعنده روح خلاء که در مناطق Abyss پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	45	Sylora
enemy_volcanic_269	Volcanic	دیو گدازه آتشفشان	rank_s	{"gold_max": 650, "gold_min": 65, "possible_drops": ["item_glacial_102"]}	loc_volcanic_069	موجودی خطرناک به نام دیو گدازه آتشفشان که در مناطق Volcanic پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	52	Sylora
enemy_glacial_270	Glacial	خرس قطبی وحشی کولاک ابدی	rank_ss	{"gold_max": 900, "gold_min": 90, "possible_drops": ["item_volcanic_117"]}	loc_glacial_070	موجودی خطرناک به نام خرس قطبی وحشی کولاک ابدی که در مناطق Glacial پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	72	Sylora
enemy_arcane_271	Arcane	توهم نوری انرژی‌های کیهانی	rank_sss	{"gold_max": 1500, "gold_min": 150, "possible_drops": ["item_volcanic_073"]}	loc_arcane_071	موجودی خطرناک به نام توهم نوری انرژی‌های کیهانی که در مناطق Arcane پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	82	Sylora
enemy_abyss_272	Abyss	شبح خلاء مرگ ابدی	rank_e	{"gold_max": 100, "gold_min": 10, "possible_drops": ["item_volcanic_037"]}	loc_abyss_072	موجودی خطرناک به نام شبح خلاء مرگ ابدی که در مناطق Abyss پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	52	Sylora
enemy_volcanic_273	Volcanic	عنصر آتش سنگ جهنمی	rank_d	{"gold_max": 150, "gold_min": 15, "possible_drops": ["item_abyss_016"]}	loc_volcanic_073	موجودی خطرناک به نام عنصر آتش سنگ جهنمی که در مناطق Volcanic پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	33	Sylora
enemy_glacial_274	Glacial	گرگ کولاک کولاک ابدی	rank_c	{"gold_max": 220, "gold_min": 22, "possible_drops": ["item_abyss_040"]}	loc_glacial_074	موجودی خطرناک به نام گرگ کولاک کولاک ابدی که در مناطق Glacial پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	45	Sylora
enemy_arcane_275	Arcane	جادوگر مرتد مانای سرکش	rank_b	{"gold_max": 300, "gold_min": 30, "possible_drops": ["item_abyss_048"]}	loc_arcane_075	موجودی خطرناک به نام جادوگر مرتد مانای سرکش که در مناطق Arcane پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	99	Sylora
enemy_abyss_276	Abyss	شبح خلاء فاسد شده	rank_a	{"gold_max": 450, "gold_min": 45, "possible_drops": ["item_volcanic_017"]}	loc_abyss_076	موجودی خطرناک به نام شبح خلاء فاسد شده که در مناطق Abyss پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	25	Sylora
enemy_volcanic_277	Volcanic	شکارچی خاکستر گدازه مذاب	rank_s	{"gold_max": 650, "gold_min": 65, "possible_drops": ["item_abyss_112"]}	loc_volcanic_077	موجودی خطرناک به نام شکارچی خاکستر گدازه مذاب که در مناطق Volcanic پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	1	Sylora
enemy_glacial_278	Glacial	گرگ کولاک کولاک ابدی	rank_ss	{"gold_max": 900, "gold_min": 90, "possible_drops": ["item_glacial_126"]}	loc_glacial_078	موجودی خطرناک به نام گرگ کولاک کولاک ابدی که در مناطق Glacial پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	60	Sylora
enemy_arcane_279	Arcane	عنصر مانا جادوی کهن	rank_sss	{"gold_max": 1500, "gold_min": 150, "possible_drops": ["item_glacial_010"]}	loc_arcane_079	موجودی خطرناک به نام عنصر مانا جادوی کهن که در مناطق Arcane پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	11	Sylora
enemy_abyss_280	Abyss	شبح خلاء مرگ ابدی	rank_e	{"gold_max": 100, "gold_min": 10, "possible_drops": ["item_arcane_131"]}	loc_abyss_080	موجودی خطرناک به نام شبح خلاء مرگ ابدی که در مناطق Abyss پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	63	Sylora
enemy_volcanic_281	Volcanic	عنصر آتش سنگ جهنمی	rank_d	{"gold_max": 150, "gold_min": 15, "possible_drops": ["item_glacial_082"]}	loc_volcanic_081	موجودی خطرناک به نام عنصر آتش سنگ جهنمی که در مناطق Volcanic پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	24	Sylora
enemy_glacial_282	Glacial	غول یخی یخبندان شمالی	rank_c	{"gold_max": 220, "gold_min": 22, "possible_drops": ["item_volcanic_041"]}	loc_glacial_082	موجودی خطرناک به نام غول یخی یخبندان شمالی که در مناطق Glacial پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	71	Sylora
enemy_arcane_283	Arcane	کتاب جادویی سرگردان مانای سرکش	rank_b	{"gold_max": 300, "gold_min": 30, "possible_drops": ["item_abyss_044"]}	loc_arcane_083	موجودی خطرناک به نام کتاب جادویی سرگردان مانای سرکش که در مناطق Arcane پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	24	Sylora
enemy_abyss_284	Abyss	شبح خلاء خلاء	rank_a	{"gold_max": 450, "gold_min": 45, "possible_drops": ["item_volcanic_069"]}	loc_abyss_084	موجودی خطرناک به نام شبح خلاء خلاء که در مناطق Abyss پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	43	Sylora
enemy_volcanic_285	Volcanic	شکارچی خاکستر آتشفشان	rank_s	{"gold_max": 650, "gold_min": 65, "possible_drops": ["item_volcanic_025"]}	loc_volcanic_085	موجودی خطرناک به نام شکارچی خاکستر آتشفشان که در مناطق Volcanic پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	61	Sylora
enemy_glacial_286	Glacial	غول یخی یخبندان شمالی	rank_ss	{"gold_max": 900, "gold_min": 90, "possible_drops": ["item_volcanic_105"]}	loc_glacial_086	موجودی خطرناک به نام غول یخی یخبندان شمالی که در مناطق Glacial پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	89	Sylora
enemy_arcane_287	Arcane	توهم نوری جادوی کهن	rank_sss	{"gold_max": 1500, "gold_min": 150, "possible_drops": ["item_arcane_003"]}	loc_arcane_087	موجودی خطرناک به نام توهم نوری جادوی کهن که در مناطق Arcane پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	26	Sylora
enemy_abyss_288	Abyss	نگهبان تاریکی سایه‌های سرگردان	rank_e	{"gold_max": 100, "gold_min": 10, "possible_drops": ["item_abyss_144"]}	loc_abyss_088	موجودی خطرناک به نام نگهبان تاریکی سایه‌های سرگردان که در مناطق Abyss پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	64	Sylora
enemy_volcanic_289	Volcanic	شکارچی خاکستر سنگ جهنمی	rank_d	{"gold_max": 150, "gold_min": 15, "possible_drops": ["item_volcanic_005"]}	loc_volcanic_089	موجودی خطرناک به نام شکارچی خاکستر سنگ جهنمی که در مناطق Volcanic پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	29	Sylora
enemy_glacial_290	Glacial	نگهبان بلورین زمستان تاریک	rank_c	{"gold_max": 220, "gold_min": 22, "possible_drops": ["item_volcanic_133"]}	loc_glacial_090	موجودی خطرناک به نام نگهبان بلورین زمستان تاریک که در مناطق Glacial پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	64	Sylora
enemy_arcane_291	Arcane	جادوگر مرتد ستاره‌شناسان	rank_b	{"gold_max": 300, "gold_min": 30, "possible_drops": ["item_arcane_075"]}	loc_arcane_091	موجودی خطرناک به نام جادوگر مرتد ستاره‌شناسان که در مناطق Arcane پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	53	Sylora
enemy_abyss_292	Abyss	نگهبان تاریکی سایه‌های سرگردان	rank_a	{"gold_max": 450, "gold_min": 45, "possible_drops": ["item_arcane_051"]}	loc_abyss_092	موجودی خطرناک به نام نگهبان تاریکی سایه‌های سرگردان که در مناطق Abyss پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	31	Sylora
enemy_volcanic_293	Volcanic	اژدهای خفته گدازه مذاب	rank_s	{"gold_max": 650, "gold_min": 65, "possible_drops": ["item_volcanic_089"]}	loc_volcanic_093	موجودی خطرناک به نام اژدهای خفته گدازه مذاب که در مناطق Volcanic پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	25	Sylora
enemy_glacial_294	Glacial	خرس قطبی وحشی سرمای استخوان‌سوز	rank_ss	{"gold_max": 900, "gold_min": 90, "possible_drops": ["item_volcanic_081"]}	loc_glacial_094	موجودی خطرناک به نام خرس قطبی وحشی سرمای استخوان‌سوز که در مناطق Glacial پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	83	Sylora
enemy_arcane_295	Arcane	توهم نوری مانای سرکش	rank_sss	{"gold_max": 1500, "gold_min": 150, "possible_drops": ["item_arcane_079"]}	loc_arcane_095	موجودی خطرناک به نام توهم نوری مانای سرکش که در مناطق Arcane پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	73	Sylora
enemy_abyss_296	Abyss	شبح خلاء فاسد شده	rank_e	{"gold_max": 100, "gold_min": 10, "possible_drops": ["item_glacial_010"]}	loc_abyss_096	موجودی خطرناک به نام شبح خلاء فاسد شده که در مناطق Abyss پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	67	Sylora
enemy_volcanic_297	Volcanic	دیو گدازه آتش ابدی	rank_d	{"gold_max": 150, "gold_min": 15, "possible_drops": ["item_arcane_111"]}	loc_volcanic_097	موجودی خطرناک به نام دیو گدازه آتش ابدی که در مناطق Volcanic پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	69	Sylora
enemy_glacial_298	Glacial	خرس قطبی وحشی زمستان تاریک	rank_c	{"gold_max": 220, "gold_min": 22, "possible_drops": ["item_arcane_131"]}	loc_glacial_098	موجودی خطرناک به نام خرس قطبی وحشی زمستان تاریک که در مناطق Glacial پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	56	Sylora
enemy_arcane_299	Arcane	عنصر مانا ستاره‌شناسان	rank_b	{"gold_max": 300, "gold_min": 30, "possible_drops": ["item_arcane_103"]}	loc_arcane_099	موجودی خطرناک به نام عنصر مانا ستاره‌شناسان که در مناطق Arcane پرسه می‌زند. این موجود به دلیل سازگاری با محیط، دارای قدرت‌های دفاعی و هجومی ویژه‌ای است.	29	Sylora
\.


--
-- Data for Name: enemy_instance; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.enemy_instance (instance_id, enemy_id, level, hp, mana, location_id, extra_properties, energy, spawn_at) FROM stdin;
\.


--
-- Data for Name: enemy_stats; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.enemy_stats (enemy_id, strength, speed, mana, energy, hp, luck, base_hp, base_mana, base_energy) FROM stdin;
enemy_abyss_104	1	1	4	1	13	1	13	4	1
enemy_abyss_108	3	2	18	1	55	1	55	18	1
enemy_abyss_112	2	1	12	1	37	1	37	12	1
enemy_abyss_116	11	7	59	1	179	1	179	59	1
enemy_abyss_120	4	3	25	1	75	1	75	25	1
enemy_abyss_124	8	5	43	1	131	1	131	43	1
enemy_abyss_128	3	2	16	1	49	1	49	16	1
enemy_abyss_132	14	8	70	1	210	1	210	70	1
enemy_abyss_136	2	1	13	1	40	1	40	13	1
enemy_abyss_140	20	12	100	1	300	1	300	100	1
enemy_abyss_144	4	2	20	1	60	1	60	20	1
enemy_abyss_148	15	9	79	1	238	1	238	79	1
enemy_abyss_152	4	2	21	1	64	1	64	21	1
enemy_abyss_156	13	8	65	1	196	1	196	65	1
enemy_abyss_160	4	2	20	1	60	1	60	20	1
enemy_abyss_164	18	11	92	1	276	1	276	92	1
enemy_abyss_168	2	1	12	1	38	1	38	12	1
enemy_abyss_172	19	12	99	1	297	1	297	99	1
enemy_abyss_176	1	1	3	1	9	1	9	3	1
enemy_abyss_180	21	13	105	1	317	1	317	105	1
enemy_abyss_184	1	1	5	1	17	1	17	5	1
enemy_abyss_188	3	2	18	1	55	1	55	18	1
enemy_abyss_192	4	2	21	1	63	1	63	21	1
enemy_abyss_196	18	11	94	1	283	1	283	94	1
enemy_abyss_200	3	2	17	1	51	1	51	17	1
enemy_abyss_204	3	2	19	1	58	1	58	19	1
enemy_abyss_208	1	1	4	1	12	1	12	4	1
enemy_abyss_212	11	7	56	1	169	1	169	56	1
enemy_abyss_216	2	1	13	1	39	1	39	13	1
enemy_abyss_220	22	14	112	1	338	1	338	112	1
enemy_abyss_224	1	1	9	1	29	1	29	9	1
enemy_abyss_228	14	9	73	1	221	1	221	73	1
enemy_abyss_232	3	1	15	1	46	1	46	15	1
enemy_abyss_236	12	7	61	1	183	1	183	61	1
enemy_abyss_240	4	2	22	1	66	1	66	22	1
enemy_abyss_244	18	11	90	1	272	1	272	90	1
enemy_abyss_248	3	2	17	1	52	1	52	17	1
enemy_abyss_252	19	12	96	1	290	1	290	96	1
enemy_abyss_256	2	1	14	1	43	1	43	14	1
enemy_abyss_260	18	11	90	1	272	1	272	90	1
enemy_abyss_264	4	2	20	1	61	1	61	20	1
enemy_abyss_268	11	7	57	1	172	1	172	57	1
enemy_abyss_272	4	2	22	1	66	1	66	22	1
enemy_abyss_276	2	1	14	1	44	1	44	14	1
enemy_abyss_280	4	2	23	1	70	1	70	23	1
enemy_abyss_284	5	3	26	1	79	1	79	26	1
enemy_abyss_288	1	1	4	1	12	1	12	4	1
enemy_abyss_292	19	11	95	1	286	1	286	95	1
enemy_abyss_296	4	2	20	1	62	1	62	20	1
enemy_arcane_003	2	1	14	1	43	1	43	14	1
enemy_arcane_007	23	14	119	1	357	1	357	119	1
enemy_arcane_011	7	4	38	1	115	1	115	38	1
enemy_arcane_015	59	36	295	1	887	1	887	295	1
enemy_arcane_019	3	2	19	1	59	1	59	19	1
enemy_arcane_023	72	45	364	1	1094	1	1094	364	1
enemy_arcane_027	13	8	67	1	202	1	202	67	1
enemy_arcane_031	68	42	341	1	1025	1	1025	341	1
enemy_arcane_035	6	4	34	1	103	1	103	34	1
enemy_arcane_039	54	34	272	1	817	1	817	272	1
enemy_arcane_043	11	7	58	1	175	1	175	58	1
enemy_arcane_047	32	20	161	1	483	1	483	161	1
enemy_arcane_051	11	7	57	1	172	1	172	57	1
enemy_arcane_055	67	42	337	1	1013	1	1013	337	1
enemy_arcane_059	14	9	72	1	218	1	218	72	1
enemy_arcane_063	14	9	72	1	218	1	218	72	1
enemy_arcane_067	3	2	18	1	55	1	55	18	1
enemy_arcane_071	76	47	380	1	1140	1	1140	380	1
enemy_arcane_075	7	4	35	1	105	1	105	35	1
enemy_arcane_079	35	22	176	1	529	1	529	176	1
enemy_arcane_083	6	4	32	1	96	1	96	32	1
enemy_arcane_087	73	46	368	1	1105	1	1105	368	1
enemy_arcane_091	5	3	29	1	89	1	89	29	1
enemy_arcane_095	71	44	357	1	1071	1	1071	357	1
enemy_arcane_099	5	3	27	1	82	1	82	27	1
enemy_arcane_103	14	9	72	1	218	1	218	72	1
enemy_arcane_107	4	2	23	1	71	1	71	23	1
enemy_arcane_111	38	24	192	1	576	1	576	192	1
enemy_arcane_115	11	7	59	1	177	1	177	59	1
enemy_arcane_119	19	12	99	1	299	1	299	99	1
enemy_arcane_123	14	9	72	1	218	1	218	72	1
enemy_arcane_127	67	42	337	1	1013	1	1013	337	1
enemy_arcane_131	13	8	68	1	205	1	205	68	1
enemy_arcane_135	34	21	172	1	518	1	518	172	1
enemy_arcane_139	10	6	54	1	163	1	163	54	1
enemy_arcane_143	58	36	291	1	875	1	875	291	1
enemy_arcane_147	6	4	32	1	96	1	96	32	1
enemy_arcane_151	57	36	288	1	864	1	864	288	1
enemy_arcane_155	13	8	67	1	202	1	202	67	1
enemy_arcane_159	72	45	364	1	1094	1	1094	364	1
enemy_arcane_163	2	1	14	1	43	1	43	14	1
enemy_arcane_167	18	11	92	1	276	1	276	92	1
enemy_arcane_171	15	9	76	1	228	1	228	76	1
enemy_arcane_175	35	22	176	1	529	1	529	176	1
enemy_arcane_179	7	4	35	1	105	1	105	35	1
enemy_arcane_183	32	20	161	1	483	1	483	161	1
enemy_arcane_187	14	9	73	1	221	1	221	73	1
enemy_arcane_191	29	18	149	1	449	1	449	149	1
enemy_arcane_195	14	8	71	1	214	1	214	71	1
enemy_arcane_199	27	17	138	1	414	1	414	138	1
enemy_arcane_203	2	1	14	1	43	1	43	14	1
enemy_arcane_207	23	14	119	1	357	1	357	119	1
enemy_arcane_211	7	4	38	1	115	1	115	38	1
enemy_arcane_215	59	36	295	1	887	1	887	295	1
enemy_arcane_219	3	2	19	1	59	1	59	19	1
enemy_arcane_223	72	45	364	1	1094	1	1094	364	1
enemy_arcane_227	13	8	67	1	202	1	202	67	1
enemy_arcane_231	68	42	341	1	1025	1	1025	341	1
enemy_arcane_235	6	4	34	1	103	1	103	34	1
enemy_arcane_239	54	34	272	1	817	1	817	272	1
enemy_arcane_243	11	7	58	1	175	1	175	58	1
enemy_arcane_247	32	20	161	1	483	1	483	161	1
enemy_arcane_251	11	7	57	1	172	1	172	57	1
enemy_arcane_255	67	42	337	1	1013	1	1013	337	1
enemy_arcane_259	14	9	72	1	218	1	218	72	1
enemy_arcane_263	14	9	72	1	218	1	218	72	1
enemy_arcane_267	3	2	18	1	55	1	55	18	1
enemy_arcane_271	76	47	380	1	1140	1	1140	380	1
enemy_arcane_275	7	4	35	1	105	1	105	35	1
enemy_arcane_279	35	22	176	1	529	1	529	176	1
enemy_arcane_283	6	4	32	1	96	1	96	32	1
enemy_arcane_287	73	46	368	1	1105	1	1105	368	1
enemy_arcane_291	5	3	29	1	89	1	89	29	1
enemy_arcane_295	71	44	357	1	1071	1	1071	357	1
enemy_arcane_299	5	3	27	1	82	1	82	27	1
enemy_glacial_002	8	5	45	1	135	1	135	45	1
enemy_glacial_006	44	27	221	1	663	1	663	221	1
enemy_glacial_010	8	5	40	1	121	1	121	40	1
enemy_glacial_014	20	12	101	1	304	1	304	101	1
enemy_glacial_018	3	2	18	1	54	1	54	18	1
enemy_glacial_022	29	18	149	1	449	1	449	149	1
enemy_glacial_026	4	2	23	1	70	1	70	23	1
enemy_glacial_030	35	22	179	1	539	1	539	179	1
enemy_glacial_034	2	1	14	1	42	1	42	14	1
enemy_glacial_038	16	10	82	1	248	1	248	82	1
enemy_glacial_042	5	3	29	1	89	1	89	29	1
enemy_glacial_046	8	5	41	1	124	1	124	41	1
enemy_glacial_050	9	5	45	1	136	1	136	45	1
enemy_glacial_054	43	27	216	1	649	1	649	216	1
enemy_glacial_058	2	1	10	1	30	1	30	10	1
enemy_glacial_062	8	5	43	1	131	1	131	43	1
enemy_glacial_066	1	1	5	1	16	1	16	5	1
enemy_glacial_070	31	19	156	1	470	1	470	156	1
enemy_glacial_074	1	1	7	1	23	1	23	7	1
enemy_glacial_078	43	27	218	1	656	1	656	218	1
enemy_glacial_082	1	1	8	1	25	1	25	8	1
enemy_glacial_086	7	4	36	1	110	1	110	36	1
enemy_glacial_090	4	2	21	1	65	1	65	21	1
enemy_glacial_094	26	16	131	1	393	1	393	131	1
enemy_glacial_098	11	6	55	1	167	1	167	55	1
enemy_glacial_102	36	23	184	1	552	1	552	184	1
enemy_glacial_106	10	6	54	1	162	1	162	54	1
enemy_glacial_110	33	20	165	1	497	1	497	165	1
enemy_glacial_114	4	3	24	1	74	1	74	24	1
enemy_glacial_118	14	9	73	1	221	1	221	73	1
enemy_glacial_122	7	4	36	1	109	1	109	36	1
enemy_glacial_126	19	12	96	1	290	1	290	96	1
enemy_glacial_130	8	5	43	1	131	1	131	43	1
enemy_glacial_134	11	7	57	1	172	1	172	57	1
enemy_glacial_138	4	2	20	1	60	1	60	20	1
enemy_glacial_142	24	15	122	1	366	1	366	122	1
enemy_glacial_146	2	1	10	1	30	1	30	10	1
enemy_glacial_150	37	23	186	1	559	1	559	186	1
enemy_glacial_154	10	6	52	1	158	1	158	52	1
enemy_glacial_158	8	5	41	1	124	1	124	41	1
enemy_glacial_162	2	1	10	1	32	1	32	10	1
enemy_glacial_166	4	2	23	1	69	1	69	23	1
enemy_glacial_170	7	4	38	1	114	1	114	38	1
enemy_glacial_174	6	4	32	1	96	1	96	32	1
enemy_glacial_178	10	6	53	1	160	1	160	53	1
enemy_glacial_182	6	4	34	1	103	1	103	34	1
enemy_glacial_186	1	1	8	1	26	1	26	8	1
enemy_glacial_190	17	11	89	1	269	1	269	89	1
enemy_glacial_194	6	4	32	1	96	1	96	32	1
enemy_glacial_198	45	28	228	1	684	1	684	228	1
enemy_glacial_202	8	5	45	1	135	1	135	45	1
enemy_glacial_206	44	27	221	1	663	1	663	221	1
enemy_glacial_210	8	5	40	1	121	1	121	40	1
enemy_glacial_214	20	12	101	1	304	1	304	101	1
enemy_glacial_218	3	2	18	1	54	1	54	18	1
enemy_glacial_222	29	18	149	1	449	1	449	149	1
enemy_glacial_226	4	2	23	1	70	1	70	23	1
enemy_glacial_230	35	22	179	1	539	1	539	179	1
enemy_glacial_234	2	1	14	1	42	1	42	14	1
enemy_glacial_238	16	10	82	1	248	1	248	82	1
enemy_glacial_242	5	3	29	1	89	1	89	29	1
enemy_glacial_246	8	5	41	1	124	1	124	41	1
enemy_glacial_250	9	5	45	1	136	1	136	45	1
enemy_glacial_254	43	27	216	1	649	1	649	216	1
enemy_glacial_258	2	1	10	1	30	1	30	10	1
enemy_glacial_262	8	5	43	1	131	1	131	43	1
enemy_glacial_266	1	1	5	1	16	1	16	5	1
enemy_glacial_270	31	19	156	1	470	1	470	156	1
enemy_glacial_274	1	1	7	1	23	1	23	7	1
enemy_glacial_278	43	27	218	1	656	1	656	218	1
enemy_abyss_000	3	2	17	1	51	1	51	17	1
enemy_abyss_004	3	2	19	1	58	1	58	19	1
enemy_abyss_008	1	1	4	1	12	1	12	4	1
enemy_abyss_012	11	7	56	1	169	1	169	56	1
enemy_abyss_016	2	1	13	1	39	1	39	13	1
enemy_abyss_020	22	14	112	1	338	1	338	112	1
enemy_abyss_024	1	1	9	1	29	1	29	9	1
enemy_abyss_028	14	9	73	1	221	1	221	73	1
enemy_abyss_032	3	1	15	1	46	1	46	15	1
enemy_abyss_036	12	7	61	1	183	1	183	61	1
enemy_abyss_040	4	2	22	1	66	1	66	22	1
enemy_abyss_044	18	11	90	1	272	1	272	90	1
enemy_abyss_048	3	2	17	1	52	1	52	17	1
enemy_abyss_052	19	12	96	1	290	1	290	96	1
enemy_abyss_056	2	1	14	1	43	1	43	14	1
enemy_abyss_060	18	11	90	1	272	1	272	90	1
enemy_abyss_064	4	2	20	1	61	1	61	20	1
enemy_abyss_068	11	7	57	1	172	1	172	57	1
enemy_abyss_072	4	2	22	1	66	1	66	22	1
enemy_abyss_076	2	1	14	1	44	1	44	14	1
enemy_abyss_080	4	2	23	1	70	1	70	23	1
enemy_abyss_084	5	3	26	1	79	1	79	26	1
enemy_abyss_088	1	1	4	1	12	1	12	4	1
enemy_abyss_092	19	11	95	1	286	1	286	95	1
enemy_abyss_096	4	2	20	1	62	1	62	20	1
enemy_abyss_100	15	9	77	1	231	1	231	77	1
enemy_volcanic_049	7	4	36	1	108	1	108	36	1
enemy_volcanic_053	32	20	163	1	489	1	489	163	1
enemy_volcanic_057	1	1	9	1	27	1	27	9	1
enemy_volcanic_061	14	8	71	1	214	1	214	71	1
enemy_volcanic_065	3	2	19	1	59	1	59	19	1
enemy_volcanic_069	21	13	108	1	324	1	324	108	1
enemy_volcanic_073	5	3	26	1	78	1	78	26	1
enemy_volcanic_077	4	2	21	1	64	1	64	21	1
enemy_volcanic_081	5	3	24	1	79	1	79	24	1
enemy_volcanic_085	12	8	64	1	194	1	194	64	1
enemy_volcanic_089	6	3	30	1	92	1	92	30	1
enemy_volcanic_093	8	5	44	1	134	1	134	44	1
enemy_volcanic_097	1	1	4	1	13	1	13	4	1
enemy_volcanic_101	3	2	18	1	54	1	54	18	1
enemy_volcanic_105	7	4	36	1	108	1	108	36	1
enemy_volcanic_109	20	12	101	1	304	1	304	101	1
enemy_volcanic_113	7	4	37	1	111	1	111	37	1
enemy_volcanic_117	17	11	89	1	269	1	269	89	1
enemy_volcanic_121	6	4	32	1	99	1	99	32	1
enemy_volcanic_125	33	20	166	1	499	1	499	166	1
enemy_volcanic_129	4	2	24	1	72	1	72	24	1
enemy_volcanic_133	4	2	21	1	64	1	64	21	1
enemy_volcanic_137	3	1	15	1	47	1	47	15	1
enemy_volcanic_141	15	9	79	1	239	1	239	79	1
enemy_volcanic_145	1	1	8	1	24	1	24	8	1
enemy_volcanic_149	31	19	156	1	469	1	469	156	1
enemy_volcanic_153	7	4	37	1	112	1	112	37	1
enemy_volcanic_157	7	4	39	1	119	1	119	39	1
enemy_volcanic_161	3	2	16	1	49	1	49	16	1
enemy_volcanic_165	17	10	86	1	259	1	259	86	1
enemy_volcanic_169	4	3	24	1	74	1	74	24	1
enemy_volcanic_173	22	14	113	1	339	1	339	113	1
enemy_volcanic_177	1	1	4	1	14	1	14	4	1
enemy_volcanic_181	22	14	104	1	343	1	343	104	1
enemy_volcanic_185	2	1	14	1	44	1	44	14	1
enemy_volcanic_189	26	16	133	1	399	1	399	133	1
enemy_volcanic_193	2	1	10	1	31	1	31	10	1
enemy_volcanic_197	3	2	19	1	59	1	59	19	1
enemy_volcanic_201	1	1	4	1	12	1	12	4	1
enemy_volcanic_205	31	19	156	1	469	1	469	156	1
enemy_volcanic_209	4	2	23	1	70	1	70	23	1
enemy_volcanic_213	32	20	161	1	484	1	484	161	1
enemy_volcanic_217	4	2	20	1	62	1	62	20	1
enemy_volcanic_221	28	17	143	1	429	1	429	143	1
enemy_glacial_282	1	1	8	1	25	1	25	8	1
enemy_glacial_286	7	4	36	1	110	1	110	36	1
enemy_glacial_290	4	2	21	1	65	1	65	21	1
enemy_glacial_294	26	16	131	1	393	1	393	131	1
enemy_glacial_298	11	6	55	1	167	1	167	55	1
enemy_volcanic_001	1	1	4	1	12	1	12	4	1
enemy_volcanic_005	31	19	156	1	469	1	469	156	1
enemy_volcanic_009	4	2	23	1	70	1	70	23	1
enemy_volcanic_013	32	20	161	1	484	1	484	161	1
enemy_volcanic_017	4	2	20	1	62	1	62	20	1
enemy_volcanic_021	28	17	143	1	429	1	429	143	1
enemy_volcanic_025	7	4	38	1	115	1	115	38	1
enemy_volcanic_029	20	13	104	1	314	1	314	104	1
enemy_volcanic_033	1	1	4	1	14	1	14	4	1
enemy_volcanic_037	13	8	68	1	204	1	204	68	1
enemy_volcanic_041	3	2	18	1	55	1	55	18	1
enemy_volcanic_045	6	4	34	1	104	1	104	34	1
enemy_volcanic_225	7	4	38	1	115	1	115	38	1
enemy_volcanic_229	20	13	104	1	314	1	314	104	1
enemy_volcanic_233	1	1	4	1	14	1	14	4	1
enemy_volcanic_237	13	8	68	1	204	1	204	68	1
enemy_volcanic_241	3	2	18	1	55	1	55	18	1
enemy_volcanic_245	6	4	34	1	104	1	104	34	1
enemy_volcanic_249	7	4	36	1	108	1	108	36	1
enemy_volcanic_253	32	20	163	1	489	1	489	163	1
enemy_volcanic_257	1	1	9	1	27	1	27	9	1
enemy_volcanic_261	14	8	71	1	214	1	214	71	1
enemy_volcanic_265	3	2	19	1	59	1	59	19	1
enemy_volcanic_269	21	13	108	1	324	1	324	108	1
enemy_volcanic_273	5	3	26	1	78	1	78	26	1
enemy_volcanic_277	4	2	21	1	64	1	64	21	1
enemy_volcanic_281	5	3	26	1	79	1	79	26	1
enemy_volcanic_285	12	8	64	1	194	1	194	64	1
enemy_volcanic_289	6	3	30	1	92	1	92	30	1
enemy_volcanic_293	8	5	44	1	134	1	134	44	1
enemy_volcanic_297	1	1	4	1	13	1	13	4	1
\.


--
-- Data for Name: equipment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.equipment (equipment_id, item_id, character_id, slot_type, enhancement_level, durability, max_durability, equipped_at, unequipped_at, is_equipped, extra_json) FROM stdin;
\.


--
-- Data for Name: event_history; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.event_history (player_id, event_type, event_data, created_at, event_id) FROM stdin;
\.


--
-- Data for Name: family_background; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.family_background (background_id, name, description, starting_items, start_skill, spawn_weight) FROM stdin;
\.


--
-- Data for Name: guild; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.guild (guild_id, name, leader_character_id, description, motto, level, exp, created_at, updated_at, is_active) FROM stdin;
\.


--
-- Data for Name: guild_member; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.guild_member (guild_id, character_id, member_role, joined_at, left_at, is_active) FROM stdin;
\.


--
-- Data for Name: inventory; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.inventory (character_id, item_id, quantity) FROM stdin;
\.


--
-- Data for Name: item; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.item (item_id, name, rarity, type, description, effect_json, rarity_weight) FROM stdin;
item_abyss_000	عصای خلاء سایه‌های سرگردان	Common	Weapon	یک عصای خلاء سایه‌های سرگردان با کیفیت Common. این آیتم در اعماق اقلیم قلمرو خلاء و سایه ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 36 مناسب است.	{"damage": 46, "stat_bonus": "black_knowledge_level"}	90
item_volcanic_001	زره پولادی کوره خاکستر سرخ	Uncommon	Armor	یک زره پولادی کوره خاکستر سرخ با کیفیت Uncommon. این آیتم در اعماق اقلیم سرزمین‌های گدازه و خاکستر ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 12 مناسب است.	{"defense": 46, "hp_bonus": 209}	2
item_glacial_002	تبر یخی کولاک ابدی	Rare	Potion	یک تبر یخی کولاک ابدی با کیفیت Rare. این آیتم در اعماق اقلیم دشت‌های منجمد شمالی ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 25 مناسب است.	{"target": "hp", "restore_value": 117}	98
item_arcane_003	حلقه کیهانی ستاره‌شناسان	Epic	Relic	یک حلقه کیهانی ستاره‌شناسان با کیفیت Epic. این آیتم در اعماق اقلیم ارگ ماورایی مانا ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 49 مناسب است.	{"value": 7, "special_buff": "aura_arcane"}	48
item_abyss_004	عصای خلاء خلاء	Legendary	QuestItem	یک عصای خلاء خلاء با کیفیت Legendary. این آیتم در اعماق اقلیم قلمرو خلاء و سایه ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 1 مناسب است.	{"value": 3, "special_buff": "aura_abyss"}	70
item_volcanic_005	زره پولادی کوره گدازه مذاب	Common	Weapon	یک زره پولادی کوره گدازه مذاب با کیفیت Common. این آیتم در اعماق اقلیم سرزمین‌های گدازه و خاکستر ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 2 مناسب است.	{"damage": 112, "stat_bonus": "strength"}	24
item_glacial_006	کلاهخود بلورین زمستان تاریک	Uncommon	Armor	یک کلاهخود بلورین زمستان تاریک با کیفیت Uncommon. این آیتم در اعماق اقلیم دشت‌های منجمد شمالی ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 43 مناسب است.	{"defense": 18, "hp_bonus": 82}	79
item_arcane_007	کتاب طلسمات کهن انرژی‌های کیهانی	Rare	Potion	یک کتاب طلسمات کهن انرژی‌های کیهانی با کیفیت Rare. این آیتم در اعماق اقلیم ارگ ماورایی مانا ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 20 مناسب است.	{"target": "mana", "restore_value": 311}	84
item_abyss_008	عصای خلاء مرگ ابدی	Epic	Relic	یک عصای خلاء مرگ ابدی با کیفیت Epic. این آیتم در اعماق اقلیم قلمرو خلاء و سایه ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 50 مناسب است.	{"value": 5, "special_buff": "aura_abyss"}	90
item_volcanic_009	سپر آتشین آتش ابدی	Legendary	QuestItem	یک سپر آتشین آتش ابدی با کیفیت Legendary. این آیتم در اعماق اقلیم سرزمین‌های گدازه و خاکستر ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 11 مناسب است.	{"value": 3, "special_buff": "aura_volcanic"}	11
item_glacial_010	کلاهخود بلورین زمستان تاریک	Common	Weapon	یک کلاهخود بلورین زمستان تاریک با کیفیت Common. این آیتم در اعماق اقلیم دشت‌های منجمد شمالی ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 42 مناسب است.	{"damage": 113, "stat_bonus": "defense"}	64
item_arcane_011	عصای مانا اسرار باستانی	Uncommon	Armor	یک عصای مانا اسرار باستانی با کیفیت Uncommon. این آیتم در اعماق اقلیم ارگ ماورایی مانا ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 18 مناسب است.	{"defense": 30, "hp_bonus": 129}	78
item_abyss_012	عصای خلاء ظلمت	Rare	Potion	یک عصای خلاء ظلمت با کیفیت Rare. این آیتم در اعماق اقلیم قلمرو خلاء و سایه ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 2 مناسب است.	{"target": "hp", "restore_value": 451}	22
item_volcanic_013	زره پولادی کوره سنگ جهنمی	Epic	Relic	یک زره پولادی کوره سنگ جهنمی با کیفیت Epic. این آیتم در اعماق اقلیم سرزمین‌های گدازه و خاکستر ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 31 مناسب است.	{"value": 4, "special_buff": "aura_volcanic"}	55
item_glacial_014	کلاهخود بلورین سرمای استخوان‌سوز	Legendary	QuestItem	یک کلاهخود بلورین سرمای استخوان‌سوز با کیفیت Legendary. این آیتم در اعماق اقلیم دشت‌های منجمد شمالی ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 47 مناسب است.	{"value": 1, "special_buff": "aura_glacial"}	17
item_arcane_015	ردای ستاره‌شناس انرژی‌های کیهانی	Common	Weapon	یک ردای ستاره‌شناس انرژی‌های کیهانی با کیفیت Common. این آیتم در اعماق اقلیم ارگ ماورایی مانا ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 18 مناسب است.	{"damage": 72, "stat_bonus": "intelligence"}	14
item_abyss_016	زره روح سرگردان مرگ ابدی	Uncommon	Armor	یک زره روح سرگردان مرگ ابدی با کیفیت Uncommon. این آیتم در اعماق اقلیم قلمرو خلاء و سایه ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 3 مناسب است.	{"defense": 27, "hp_bonus": 255}	8
item_volcanic_017	سپر آتشین گدازه مذاب	Rare	Potion	یک سپر آتشین گدازه مذاب با کیفیت Rare. این آیتم در اعماق اقلیم سرزمین‌های گدازه و خاکستر ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 19 مناسب است.	{"target": "hp", "restore_value": 390}	66
item_glacial_018	طلسم زمستان یخبندان شمالی	Epic	Relic	یک طلسم زمستان یخبندان شمالی با کیفیت Epic. این آیتم در اعماق اقلیم دشت‌های منجمد شمالی ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 4 مناسب است.	{"value": 9, "special_buff": "aura_glacial"}	96
item_arcane_019	کتاب طلسمات کهن اسرار باستانی	Legendary	QuestItem	یک کتاب طلسمات کهن اسرار باستانی با کیفیت Legendary. این آیتم در اعماق اقلیم ارگ ماورایی مانا ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 47 مناسب است.	{"value": 3, "special_buff": "aura_arcane"}	92
item_abyss_020	عصای خلاء خلاء	Common	Weapon	یک عصای خلاء خلاء با کیفیت Common. این آیتم در اعماق اقلیم قلمرو خلاء و سایه ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 10 مناسب است.	{"damage": 29, "stat_bonus": "black_knowledge_level"}	29
item_volcanic_021	زره پولادی کوره آتش ابدی	Uncommon	Armor	یک زره پولادی کوره آتش ابدی با کیفیت Uncommon. این آیتم در اعماق اقلیم سرزمین‌های گدازه و خاکستر ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 3 مناسب است.	{"defense": 75, "hp_bonus": 47}	99
item_glacial_022	تبر یخی زمستان تاریک	Rare	Potion	یک تبر یخی زمستان تاریک با کیفیت Rare. این آیتم در اعماق اقلیم دشت‌های منجمد شمالی ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 24 مناسب است.	{"target": "hp", "restore_value": 483}	58
item_arcane_023	کتاب طلسمات کهن مانای سرکش	Epic	Relic	یک کتاب طلسمات کهن مانای سرکش با کیفیت Epic. این آیتم در اعماق اقلیم ارگ ماورایی مانا ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 6 مناسب است.	{"value": 2, "special_buff": "aura_arcane"}	17
item_abyss_024	خنجر سایه خلاء	Legendary	QuestItem	یک خنجر سایه خلاء با کیفیت Legendary. این آیتم در اعماق اقلیم قلمرو خلاء و سایه ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 36 مناسب است.	{"value": 8, "special_buff": "aura_abyss"}	70
item_volcanic_025	شمشیر گدازه خاکستر سرخ	Common	Weapon	یک شمشیر گدازه خاکستر سرخ با کیفیت Common. این آیتم در اعماق اقلیم سرزمین‌های گدازه و خاکستر ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 13 مناسب است.	{"damage": 37, "stat_bonus": "strength"}	67
item_glacial_026	کلاهخود بلورین بلورهای جادویی	Uncommon	Armor	یک کلاهخود بلورین بلورهای جادویی با کیفیت Uncommon. این آیتم در اعماق اقلیم دشت‌های منجمد شمالی ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 1 مناسب است.	{"defense": 62, "hp_bonus": 36}	42
item_arcane_027	عصای مانا جادوی کهن	Rare	Potion	یک عصای مانا جادوی کهن با کیفیت Rare. این آیتم در اعماق اقلیم ارگ ماورایی مانا ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 6 مناسب است.	{"target": "mana", "restore_value": 344}	90
item_abyss_028	حرز تاریکی ظلمت	Epic	Relic	یک حرز تاریکی ظلمت با کیفیت Epic. این آیتم در اعماق اقلیم قلمرو خلاء و سایه ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 47 مناسب است.	{"value": 4, "special_buff": "aura_abyss"}	35
item_volcanic_029	حلقه خاکستر سنگ جهنمی	Legendary	QuestItem	یک حلقه خاکستر سنگ جهنمی با کیفیت Legendary. این آیتم در اعماق اقلیم سرزمین‌های گدازه و خاکستر ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 11 مناسب است.	{"value": 1, "special_buff": "aura_volcanic"}	100
item_glacial_030	طلسم زمستان سرمای استخوان‌سوز	Common	Weapon	یک طلسم زمستان سرمای استخوان‌سوز با کیفیت Common. این آیتم در اعماق اقلیم دشت‌های منجمد شمالی ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 29 مناسب است.	{"damage": 147, "stat_bonus": "defense"}	44
item_arcane_031	عصای مانا انرژی‌های کیهانی	Uncommon	Armor	یک عصای مانا انرژی‌های کیهانی با کیفیت Uncommon. این آیتم در اعماق اقلیم ارگ ماورایی مانا ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 14 مناسب است.	{"defense": 22, "hp_bonus": 294}	49
item_abyss_032	عصای خلاء سایه‌های سرگردان	Rare	Potion	یک عصای خلاء سایه‌های سرگردان با کیفیت Rare. این آیتم در اعماق اقلیم قلمرو خلاء و سایه ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 17 مناسب است.	{"target": "hp", "restore_value": 386}	38
item_volcanic_033	زره پولادی کوره گدازه مذاب	Epic	Relic	یک زره پولادی کوره گدازه مذاب با کیفیت Epic. این آیتم در اعماق اقلیم سرزمین‌های گدازه و خاکستر ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 10 مناسب است.	{"value": 8, "special_buff": "aura_volcanic"}	31
item_glacial_034	دستکش‌های منجمد سرمای استخوان‌سوز	Legendary	QuestItem	یک دستکش‌های منجمد سرمای استخوان‌سوز با کیفیت Legendary. این آیتم در اعماق اقلیم دشت‌های منجمد شمالی ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 47 مناسب است.	{"value": 9, "special_buff": "aura_glacial"}	24
item_arcane_035	ردای ستاره‌شناس اسرار باستانی	Common	Weapon	یک ردای ستاره‌شناس اسرار باستانی با کیفیت Common. این آیتم در اعماق اقلیم ارگ ماورایی مانا ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 13 مناسب است.	{"damage": 53, "stat_bonus": "intelligence"}	79
item_abyss_036	عصای خلاء مرگ ابدی	Uncommon	Armor	یک عصای خلاء مرگ ابدی با کیفیت Uncommon. این آیتم در اعماق اقلیم قلمرو خلاء و سایه ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 14 مناسب است.	{"defense": 40, "hp_bonus": 120}	84
item_volcanic_037	زره پولادی کوره آتش ابدی	Rare	Potion	یک زره پولادی کوره آتش ابدی با کیفیت Rare. این آیتم در اعماق اقلیم سرزمین‌های گدازه و خاکستر ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 48 مناسب است.	{"target": "hp", "restore_value": 241}	41
item_glacial_038	دستکش‌های منجمد سرمای استخوان‌سوز	Epic	Relic	یک دستکش‌های منجمد سرمای استخوان‌سوز با کیفیت Epic. این آیتم در اعماق اقلیم دشت‌های منجمد شمالی ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 43 مناسب است.	{"value": 9, "special_buff": "aura_glacial"}	46
item_arcane_039	کتاب طلسمات کهن اسرار باستانی	Legendary	QuestItem	یک کتاب طلسمات کهن اسرار باستانی با کیفیت Legendary. این آیتم در اعماق اقلیم ارگ ماورایی مانا ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 25 مناسب است.	{"value": 3, "special_buff": "aura_arcane"}	13
item_abyss_040	حرز تاریکی ظلمت	Common	Weapon	یک حرز تاریکی ظلمت با کیفیت Common. این آیتم در اعماق اقلیم قلمرو خلاء و سایه ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 13 مناسب است.	{"damage": 95, "stat_bonus": "black_knowledge_level"}	59
item_volcanic_041	زره پولادی کوره گدازه مذاب	Uncommon	Armor	یک زره پولادی کوره گدازه مذاب با کیفیت Uncommon. این آیتم در اعماق اقلیم سرزمین‌های گدازه و خاکستر ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 4 مناسب است.	{"defense": 43, "hp_bonus": 107}	38
item_glacial_042	دستکش‌های منجمد زمستان تاریک	Rare	Potion	یک دستکش‌های منجمد زمستان تاریک با کیفیت Rare. این آیتم در اعماق اقلیم دشت‌های منجمد شمالی ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 45 مناسب است.	{"target": "hp", "restore_value": 294}	70
item_arcane_043	حلقه کیهانی ستاره‌شناسان	Epic	Relic	یک حلقه کیهانی ستاره‌شناسان با کیفیت Epic. این آیتم در اعماق اقلیم ارگ ماورایی مانا ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 18 مناسب است.	{"value": 2, "special_buff": "aura_arcane"}	85
item_abyss_044	خنجر سایه فاسد شده	Legendary	QuestItem	یک خنجر سایه فاسد شده با کیفیت Legendary. این آیتم در اعماق اقلیم قلمرو خلاء و سایه ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 49 مناسب است.	{"value": 8, "special_buff": "aura_abyss"}	65
item_volcanic_045	زره پولادی کوره خاکستر سرخ	Common	Weapon	یک زره پولادی کوره خاکستر سرخ با کیفیت Common. این آیتم در اعماق اقلیم سرزمین‌های گدازه و خاکستر ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 7 مناسب است.	{"damage": 53, "stat_bonus": "strength"}	82
item_glacial_046	طلسم زمستان سرمای استخوان‌سوز	Uncommon	Armor	یک طلسم زمستان سرمای استخوان‌سوز با کیفیت Uncommon. این آیتم در اعماق اقلیم دشت‌های منجمد شمالی ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 35 مناسب است.	{"defense": 38, "hp_bonus": 259}	5
item_arcane_047	ردای ستاره‌شناس اسرار باستانی	Rare	Potion	یک ردای ستاره‌شناس اسرار باستانی با کیفیت Rare. این آیتم در اعماق اقلیم ارگ ماورایی مانا ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 48 مناسب است.	{"target": "mana", "restore_value": 453}	63
item_abyss_048	حرز تاریکی فاسد شده	Epic	Relic	یک حرز تاریکی فاسد شده با کیفیت Epic. این آیتم در اعماق اقلیم قلمرو خلاء و سایه ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 29 مناسب است.	{"value": 3, "special_buff": "aura_abyss"}	92
item_volcanic_049	شمشیر گدازه سنگ جهنمی	Legendary	QuestItem	یک شمشیر گدازه سنگ جهنمی با کیفیت Legendary. این آیتم در اعماق اقلیم سرزمین‌های گدازه و خاکستر ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 23 مناسب است.	{"value": 7, "special_buff": "aura_volcanic"}	16
item_glacial_050	کلاهخود بلورین زمستان تاریک	Common	Weapon	یک کلاهخود بلورین زمستان تاریک با کیفیت Common. این آیتم در اعماق اقلیم دشت‌های منجمد شمالی ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 49 مناسب است.	{"damage": 78, "stat_bonus": "defense"}	99
item_arcane_051	کتاب طلسمات کهن جادوی کهن	Uncommon	Armor	یک کتاب طلسمات کهن جادوی کهن با کیفیت Uncommon. این آیتم در اعماق اقلیم ارگ ماورایی مانا ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 12 مناسب است.	{"defense": 41, "hp_bonus": 251}	96
item_abyss_052	حرز تاریکی فاسد شده	Rare	Potion	یک حرز تاریکی فاسد شده با کیفیت Rare. این آیتم در اعماق اقلیم قلمرو خلاء و سایه ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 11 مناسب است.	{"target": "hp", "restore_value": 213}	87
item_volcanic_053	سپر آتشین خاکستر سرخ	Epic	Relic	یک سپر آتشین خاکستر سرخ با کیفیت Epic. این آیتم در اعماق اقلیم سرزمین‌های گدازه و خاکستر ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 40 مناسب است.	{"value": 10, "special_buff": "aura_volcanic"}	38
item_glacial_054	تبر یخی کولاک ابدی	Legendary	QuestItem	یک تبر یخی کولاک ابدی با کیفیت Legendary. این آیتم در اعماق اقلیم دشت‌های منجمد شمالی ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 4 مناسب است.	{"value": 9, "special_buff": "aura_glacial"}	100
item_arcane_055	کتاب طلسمات کهن جادوی کهن	Common	Weapon	یک کتاب طلسمات کهن جادوی کهن با کیفیت Common. این آیتم در اعماق اقلیم ارگ ماورایی مانا ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 31 مناسب است.	{"damage": 91, "stat_bonus": "intelligence"}	55
item_abyss_056	عصای خلاء مرگ ابدی	Uncommon	Armor	یک عصای خلاء مرگ ابدی با کیفیت Uncommon. این آیتم در اعماق اقلیم قلمرو خلاء و سایه ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 11 مناسب است.	{"defense": 41, "hp_bonus": 245}	34
item_volcanic_057	شمشیر گدازه آتش ابدی	Rare	Potion	یک شمشیر گدازه آتش ابدی با کیفیت Rare. این آیتم در اعماق اقلیم سرزمین‌های گدازه و خاکستر ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 33 مناسب است.	{"target": "hp", "restore_value": 225}	14
item_glacial_058	کلاهخود بلورین کولاک ابدی	Epic	Relic	یک کلاهخود بلورین کولاک ابدی با کیفیت Epic. این آیتم در اعماق اقلیم دشت‌های منجمد شمالی ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 18 مناسب است.	{"value": 10, "special_buff": "aura_glacial"}	88
item_arcane_059	عصای مانا انرژی‌های کیهانی	Legendary	QuestItem	یک عصای مانا انرژی‌های کیهانی با کیفیت Legendary. این آیتم در اعماق اقلیم ارگ ماورایی مانا ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 49 مناسب است.	{"value": 9, "special_buff": "aura_arcane"}	69
item_abyss_060	زره روح سرگردان خلاء	Common	Weapon	یک زره روح سرگردان خلاء با کیفیت Common. این آیتم در اعماق اقلیم قلمرو خلاء و سایه ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 3 مناسب است.	{"damage": 29, "stat_bonus": "black_knowledge_level"}	9
item_volcanic_061	حلقه خاکستر آتشفشان	Uncommon	Armor	یک حلقه خاکستر آتشفشان با کیفیت Uncommon. این آیتم در اعماق اقلیم سرزمین‌های گدازه و خاکستر ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 44 مناسب است.	{"defense": 56, "hp_bonus": 291}	10
item_glacial_062	کلاهخود بلورین کولاک ابدی	Rare	Potion	یک کلاهخود بلورین کولاک ابدی با کیفیت Rare. این آیتم در اعماق اقلیم دشت‌های منجمد شمالی ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 40 مناسب است.	{"target": "hp", "restore_value": 275}	36
item_arcane_063	کتاب طلسمات کهن اسرار باستانی	Epic	Relic	یک کتاب طلسمات کهن اسرار باستانی با کیفیت Epic. این آیتم در اعماق اقلیم ارگ ماورایی مانا ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 22 مناسب است.	{"value": 5, "special_buff": "aura_arcane"}	54
item_abyss_064	خنجر سایه فاسد شده	Legendary	QuestItem	یک خنجر سایه فاسد شده با کیفیت Legendary. این آیتم در اعماق اقلیم قلمرو خلاء و سایه ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 11 مناسب است.	{"value": 7, "special_buff": "aura_abyss"}	28
item_volcanic_065	زره پولادی کوره گدازه مذاب	Common	Weapon	یک زره پولادی کوره گدازه مذاب با کیفیت Common. این آیتم در اعماق اقلیم سرزمین‌های گدازه و خاکستر ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 45 مناسب است.	{"damage": 104, "stat_bonus": "strength"}	49
item_glacial_066	تبر یخی یخبندان شمالی	Uncommon	Armor	یک تبر یخی یخبندان شمالی با کیفیت Uncommon. این آیتم در اعماق اقلیم دشت‌های منجمد شمالی ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 5 مناسب است.	{"defense": 45, "hp_bonus": 78}	10
item_arcane_067	ردای ستاره‌شناس مانای سرکش	Rare	Potion	یک ردای ستاره‌شناس مانای سرکش با کیفیت Rare. این آیتم در اعماق اقلیم ارگ ماورایی مانا ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 4 مناسب است.	{"target": "mana", "restore_value": 110}	2
item_abyss_068	حرز تاریکی خلاء	Epic	Relic	یک حرز تاریکی خلاء با کیفیت Epic. این آیتم در اعماق اقلیم قلمرو خلاء و سایه ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 12 مناسب است.	{"value": 3, "special_buff": "aura_abyss"}	46
item_volcanic_069	زره پولادی کوره آتش ابدی	Legendary	QuestItem	یک زره پولادی کوره آتش ابدی با کیفیت Legendary. این آیتم در اعماق اقلیم سرزمین‌های گدازه و خاکستر ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 27 مناسب است.	{"value": 10, "special_buff": "aura_volcanic"}	40
item_glacial_070	دستکش‌های منجمد سرمای استخوان‌سوز	Common	Weapon	یک دستکش‌های منجمد سرمای استخوان‌سوز با کیفیت Common. این آیتم در اعماق اقلیم دشت‌های منجمد شمالی ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 2 مناسب است.	{"damage": 90, "stat_bonus": "defense"}	87
item_arcane_071	کتاب طلسمات کهن اسرار باستانی	Uncommon	Armor	یک کتاب طلسمات کهن اسرار باستانی با کیفیت Uncommon. این آیتم در اعماق اقلیم ارگ ماورایی مانا ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 24 مناسب است.	{"defense": 26, "hp_bonus": 250}	6
item_abyss_072	زره روح سرگردان سایه‌های سرگردان	Rare	Potion	یک زره روح سرگردان سایه‌های سرگردان با کیفیت Rare. این آیتم در اعماق اقلیم قلمرو خلاء و سایه ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 23 مناسب است.	{"target": "hp", "restore_value": 198}	75
item_volcanic_073	سپر آتشین گدازه مذاب	Epic	Relic	یک سپر آتشین گدازه مذاب با کیفیت Epic. این آیتم در اعماق اقلیم سرزمین‌های گدازه و خاکستر ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 35 مناسب است.	{"value": 1, "special_buff": "aura_volcanic"}	24
item_glacial_074	تبر یخی بلورهای جادویی	Legendary	QuestItem	یک تبر یخی بلورهای جادویی با کیفیت Legendary. این آیتم در اعماق اقلیم دشت‌های منجمد شمالی ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 9 مناسب است.	{"value": 6, "special_buff": "aura_glacial"}	24
item_arcane_075	حلقه کیهانی ستاره‌شناسان	Common	Weapon	یک حلقه کیهانی ستاره‌شناسان با کیفیت Common. این آیتم در اعماق اقلیم ارگ ماورایی مانا ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 18 مناسب است.	{"damage": 109, "stat_bonus": "intelligence"}	44
item_abyss_076	زره روح سرگردان فاسد شده	Uncommon	Armor	یک زره روح سرگردان فاسد شده با کیفیت Uncommon. این آیتم در اعماق اقلیم قلمرو خلاء و سایه ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 41 مناسب است.	{"defense": 6, "hp_bonus": 188}	11
item_volcanic_077	حلقه خاکستر آتش ابدی	Rare	Potion	یک حلقه خاکستر آتش ابدی با کیفیت Rare. این آیتم در اعماق اقلیم سرزمین‌های گدازه و خاکستر ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 8 مناسب است.	{"target": "hp", "restore_value": 489}	1
item_glacial_078	طلسم زمستان زمستان تاریک	Epic	Relic	یک طلسم زمستان زمستان تاریک با کیفیت Epic. این آیتم در اعماق اقلیم دشت‌های منجمد شمالی ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 43 مناسب است.	{"value": 9, "special_buff": "aura_glacial"}	66
item_arcane_079	ردای ستاره‌شناس ستاره‌شناسان	Legendary	QuestItem	یک ردای ستاره‌شناس ستاره‌شناسان با کیفیت Legendary. این آیتم در اعماق اقلیم ارگ ماورایی مانا ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 37 مناسب است.	{"value": 4, "special_buff": "aura_arcane"}	24
item_abyss_080	خنجر سایه خلاء	Common	Weapon	یک خنجر سایه خلاء با کیفیت Common. این آیتم در اعماق اقلیم قلمرو خلاء و سایه ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 11 مناسب است.	{"damage": 35, "stat_bonus": "black_knowledge_level"}	69
item_volcanic_081	سپر آتشین گدازه مذاب	Uncommon	Armor	یک سپر آتشین گدازه مذاب با کیفیت Uncommon. این آیتم در اعماق اقلیم سرزمین‌های گدازه و خاکستر ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 34 مناسب است.	{"defense": 48, "hp_bonus": 255}	39
item_glacial_082	دستکش‌های منجمد زمستان تاریک	Rare	Potion	یک دستکش‌های منجمد زمستان تاریک با کیفیت Rare. این آیتم در اعماق اقلیم دشت‌های منجمد شمالی ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 9 مناسب است.	{"target": "hp", "restore_value": 232}	71
item_arcane_083	ردای ستاره‌شناس انرژی‌های کیهانی	Epic	Relic	یک ردای ستاره‌شناس انرژی‌های کیهانی با کیفیت Epic. این آیتم در اعماق اقلیم ارگ ماورایی مانا ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 12 مناسب است.	{"value": 6, "special_buff": "aura_arcane"}	51
item_abyss_084	خنجر سایه فاسد شده	Legendary	QuestItem	یک خنجر سایه فاسد شده با کیفیت Legendary. این آیتم در اعماق اقلیم قلمرو خلاء و سایه ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 27 مناسب است.	{"value": 7, "special_buff": "aura_abyss"}	85
item_volcanic_085	زره پولادی کوره آتش ابدی	Common	Weapon	یک زره پولادی کوره آتش ابدی با کیفیت Common. این آیتم در اعماق اقلیم سرزمین‌های گدازه و خاکستر ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 29 مناسب است.	{"damage": 42, "stat_bonus": "strength"}	73
item_glacial_086	طلسم زمستان زمستان تاریک	Uncommon	Armor	یک طلسم زمستان زمستان تاریک با کیفیت Uncommon. این آیتم در اعماق اقلیم دشت‌های منجمد شمالی ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 42 مناسب است.	{"defense": 38, "hp_bonus": 21}	78
item_arcane_087	ردای ستاره‌شناس اسرار باستانی	Rare	Potion	یک ردای ستاره‌شناس اسرار باستانی با کیفیت Rare. این آیتم در اعماق اقلیم ارگ ماورایی مانا ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 21 مناسب است.	{"target": "mana", "restore_value": 219}	83
item_abyss_088	خنجر سایه سایه‌های سرگردان	Epic	Relic	یک خنجر سایه سایه‌های سرگردان با کیفیت Epic. این آیتم در اعماق اقلیم قلمرو خلاء و سایه ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 13 مناسب است.	{"value": 8, "special_buff": "aura_abyss"}	97
item_volcanic_089	شمشیر گدازه سنگ جهنمی	Legendary	QuestItem	یک شمشیر گدازه سنگ جهنمی با کیفیت Legendary. این آیتم در اعماق اقلیم سرزمین‌های گدازه و خاکستر ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 42 مناسب است.	{"value": 8, "special_buff": "aura_volcanic"}	34
item_glacial_090	دستکش‌های منجمد کولاک ابدی	Common	Weapon	یک دستکش‌های منجمد کولاک ابدی با کیفیت Common. این آیتم در اعماق اقلیم دشت‌های منجمد شمالی ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 20 مناسب است.	{"damage": 121, "stat_bonus": "defense"}	3
item_arcane_091	عصای مانا مانای سرکش	Uncommon	Armor	یک عصای مانا مانای سرکش با کیفیت Uncommon. این آیتم در اعماق اقلیم ارگ ماورایی مانا ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 22 مناسب است.	{"defense": 55, "hp_bonus": 89}	38
item_abyss_092	عصای خلاء خلاء	Rare	Potion	یک عصای خلاء خلاء با کیفیت Rare. این آیتم در اعماق اقلیم قلمرو خلاء و سایه ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 7 مناسب است.	{"target": "hp", "restore_value": 353}	90
item_volcanic_093	شمشیر گدازه آتش ابدی	Epic	Relic	یک شمشیر گدازه آتش ابدی با کیفیت Epic. این آیتم در اعماق اقلیم سرزمین‌های گدازه و خاکستر ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 34 مناسب است.	{"value": 9, "special_buff": "aura_volcanic"}	52
item_glacial_094	تبر یخی کولاک ابدی	Legendary	QuestItem	یک تبر یخی کولاک ابدی با کیفیت Legendary. این آیتم در اعماق اقلیم دشت‌های منجمد شمالی ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 14 مناسب است.	{"value": 7, "special_buff": "aura_glacial"}	69
item_arcane_095	ردای ستاره‌شناس اسرار باستانی	Common	Weapon	یک ردای ستاره‌شناس اسرار باستانی با کیفیت Common. این آیتم در اعماق اقلیم ارگ ماورایی مانا ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 32 مناسب است.	{"damage": 37, "stat_bonus": "intelligence"}	92
item_abyss_096	زره روح سرگردان فاسد شده	Uncommon	Armor	یک زره روح سرگردان فاسد شده با کیفیت Uncommon. این آیتم در اعماق اقلیم قلمرو خلاء و سایه ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 50 مناسب است.	{"defense": 27, "hp_bonus": 227}	46
item_volcanic_097	سپر آتشین آتش ابدی	Rare	Potion	یک سپر آتشین آتش ابدی با کیفیت Rare. این آیتم در اعماق اقلیم سرزمین‌های گدازه و خاکستر ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 6 مناسب است.	{"target": "hp", "restore_value": 302}	72
item_glacial_098	طلسم زمستان سرمای استخوان‌سوز	Epic	Relic	یک طلسم زمستان سرمای استخوان‌سوز با کیفیت Epic. این آیتم در اعماق اقلیم دشت‌های منجمد شمالی ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 44 مناسب است.	{"value": 4, "special_buff": "aura_glacial"}	77
item_arcane_099	حلقه کیهانی انرژی‌های کیهانی	Legendary	QuestItem	یک حلقه کیهانی انرژی‌های کیهانی با کیفیت Legendary. این آیتم در اعماق اقلیم ارگ ماورایی مانا ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 37 مناسب است.	{"value": 8, "special_buff": "aura_arcane"}	39
item_abyss_100	زره روح سرگردان ظلمت	Common	Weapon	یک زره روح سرگردان ظلمت با کیفیت Common. این آیتم در اعماق اقلیم قلمرو خلاء و سایه ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 15 مناسب است.	{"damage": 16, "stat_bonus": "black_knowledge_level"}	58
item_volcanic_101	شمشیر گدازه آتشفشان	Uncommon	Armor	یک شمشیر گدازه آتشفشان با کیفیت Uncommon. این آیتم در اعماق اقلیم سرزمین‌های گدازه و خاکستر ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 10 مناسب است.	{"defense": 28, "hp_bonus": 271}	78
item_glacial_102	کلاهخود بلورین یخبندان شمالی	Rare	Potion	یک کلاهخود بلورین یخبندان شمالی با کیفیت Rare. این آیتم در اعماق اقلیم دشت‌های منجمد شمالی ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 19 مناسب است.	{"target": "hp", "restore_value": 392}	54
item_arcane_103	عصای مانا مانای سرکش	Epic	Relic	یک عصای مانا مانای سرکش با کیفیت Epic. این آیتم در اعماق اقلیم ارگ ماورایی مانا ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 5 مناسب است.	{"value": 7, "special_buff": "aura_arcane"}	83
item_abyss_104	خنجر سایه مرگ ابدی	Legendary	QuestItem	یک خنجر سایه مرگ ابدی با کیفیت Legendary. این آیتم در اعماق اقلیم قلمرو خلاء و سایه ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 46 مناسب است.	{"value": 3, "special_buff": "aura_abyss"}	3
item_volcanic_105	سپر آتشین خاکستر سرخ	Common	Weapon	یک سپر آتشین خاکستر سرخ با کیفیت Common. این آیتم در اعماق اقلیم سرزمین‌های گدازه و خاکستر ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 49 مناسب است.	{"damage": 102, "stat_bonus": "strength"}	61
item_glacial_106	دستکش‌های منجمد سرمای استخوان‌سوز	Uncommon	Armor	یک دستکش‌های منجمد سرمای استخوان‌سوز با کیفیت Uncommon. این آیتم در اعماق اقلیم دشت‌های منجمد شمالی ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 49 مناسب است.	{"defense": 23, "hp_bonus": 74}	51
item_arcane_107	حلقه کیهانی انرژی‌های کیهانی	Rare	Potion	یک حلقه کیهانی انرژی‌های کیهانی با کیفیت Rare. این آیتم در اعماق اقلیم ارگ ماورایی مانا ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 50 مناسب است.	{"target": "mana", "restore_value": 176}	16
item_abyss_108	زره روح سرگردان سایه‌های سرگردان	Epic	Relic	یک زره روح سرگردان سایه‌های سرگردان با کیفیت Epic. این آیتم در اعماق اقلیم قلمرو خلاء و سایه ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 26 مناسب است.	{"value": 1, "special_buff": "aura_abyss"}	96
item_volcanic_109	سپر آتشین خاکستر سرخ	Legendary	QuestItem	یک سپر آتشین خاکستر سرخ با کیفیت Legendary. این آیتم در اعماق اقلیم سرزمین‌های گدازه و خاکستر ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 4 مناسب است.	{"value": 9, "special_buff": "aura_volcanic"}	87
item_glacial_110	کلاهخود بلورین بلورهای جادویی	Common	Weapon	یک کلاهخود بلورین بلورهای جادویی با کیفیت Common. این آیتم در اعماق اقلیم دشت‌های منجمد شمالی ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 18 مناسب است.	{"damage": 84, "stat_bonus": "defense"}	77
item_arcane_111	عصای مانا ستاره‌شناسان	Uncommon	Armor	یک عصای مانا ستاره‌شناسان با کیفیت Uncommon. این آیتم در اعماق اقلیم ارگ ماورایی مانا ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 49 مناسب است.	{"defense": 6, "hp_bonus": 234}	92
item_abyss_112	عصای خلاء سایه‌های سرگردان	Rare	Potion	یک عصای خلاء سایه‌های سرگردان با کیفیت Rare. این آیتم در اعماق اقلیم قلمرو خلاء و سایه ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 36 مناسب است.	{"target": "hp", "restore_value": 102}	85
item_volcanic_113	شمشیر گدازه گدازه مذاب	Epic	Relic	یک شمشیر گدازه گدازه مذاب با کیفیت Epic. این آیتم در اعماق اقلیم سرزمین‌های گدازه و خاکستر ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 16 مناسب است.	{"value": 9, "special_buff": "aura_volcanic"}	64
item_glacial_114	دستکش‌های منجمد بلورهای جادویی	Legendary	QuestItem	یک دستکش‌های منجمد بلورهای جادویی با کیفیت Legendary. این آیتم در اعماق اقلیم دشت‌های منجمد شمالی ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 41 مناسب است.	{"value": 6, "special_buff": "aura_glacial"}	11
item_arcane_115	حلقه کیهانی مانای سرکش	Common	Weapon	یک حلقه کیهانی مانای سرکش با کیفیت Common. این آیتم در اعماق اقلیم ارگ ماورایی مانا ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 19 مناسب است.	{"damage": 140, "stat_bonus": "intelligence"}	66
item_abyss_116	خنجر سایه خلاء	Uncommon	Armor	یک خنجر سایه خلاء با کیفیت Uncommon. این آیتم در اعماق اقلیم قلمرو خلاء و سایه ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 11 مناسب است.	{"defense": 14, "hp_bonus": 266}	86
item_volcanic_117	سپر آتشین گدازه مذاب	Rare	Potion	یک سپر آتشین گدازه مذاب با کیفیت Rare. این آیتم در اعماق اقلیم سرزمین‌های گدازه و خاکستر ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 26 مناسب است.	{"target": "hp", "restore_value": 463}	44
item_glacial_118	طلسم زمستان زمستان تاریک	Epic	Relic	یک طلسم زمستان زمستان تاریک با کیفیت Epic. این آیتم در اعماق اقلیم دشت‌های منجمد شمالی ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 31 مناسب است.	{"value": 9, "special_buff": "aura_glacial"}	51
item_arcane_119	کتاب طلسمات کهن جادوی کهن	Legendary	QuestItem	یک کتاب طلسمات کهن جادوی کهن با کیفیت Legendary. این آیتم در اعماق اقلیم ارگ ماورایی مانا ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 49 مناسب است.	{"value": 7, "special_buff": "aura_arcane"}	54
item_abyss_120	عصای خلاء مرگ ابدی	Common	Weapon	یک عصای خلاء مرگ ابدی با کیفیت Common. این آیتم در اعماق اقلیم قلمرو خلاء و سایه ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 22 مناسب است.	{"damage": 14, "stat_bonus": "black_knowledge_level"}	58
item_volcanic_121	زره پولادی کوره آتش ابدی	Uncommon	Armor	یک زره پولادی کوره آتش ابدی با کیفیت Uncommon. این آیتم در اعماق اقلیم سرزمین‌های گدازه و خاکستر ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 19 مناسب است.	{"defense": 69, "hp_bonus": 230}	34
item_glacial_122	طلسم زمستان سرمای استخوان‌سوز	Rare	Potion	یک طلسم زمستان سرمای استخوان‌سوز با کیفیت Rare. این آیتم در اعماق اقلیم دشت‌های منجمد شمالی ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 6 مناسب است.	{"target": "hp", "restore_value": 429}	38
item_arcane_123	ردای ستاره‌شناس اسرار باستانی	Epic	Relic	یک ردای ستاره‌شناس اسرار باستانی با کیفیت Epic. این آیتم در اعماق اقلیم ارگ ماورایی مانا ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 8 مناسب است.	{"value": 6, "special_buff": "aura_arcane"}	26
item_abyss_124	زره روح سرگردان مرگ ابدی	Legendary	QuestItem	یک زره روح سرگردان مرگ ابدی با کیفیت Legendary. این آیتم در اعماق اقلیم قلمرو خلاء و سایه ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 15 مناسب است.	{"value": 4, "special_buff": "aura_abyss"}	31
item_volcanic_125	سپر آتشین خاکستر سرخ	Common	Weapon	یک سپر آتشین خاکستر سرخ با کیفیت Common. این آیتم در اعماق اقلیم سرزمین‌های گدازه و خاکستر ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 49 مناسب است.	{"damage": 66, "stat_bonus": "strength"}	35
item_glacial_126	کلاهخود بلورین زمستان تاریک	Uncommon	Armor	یک کلاهخود بلورین زمستان تاریک با کیفیت Uncommon. این آیتم در اعماق اقلیم دشت‌های منجمد شمالی ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 15 مناسب است.	{"defense": 28, "hp_bonus": 146}	65
item_arcane_127	کتاب طلسمات کهن اسرار باستانی	Rare	Potion	یک کتاب طلسمات کهن اسرار باستانی با کیفیت Rare. این آیتم در اعماق اقلیم ارگ ماورایی مانا ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 14 مناسب است.	{"target": "mana", "restore_value": 185}	76
item_abyss_128	خنجر سایه مرگ ابدی	Epic	Relic	یک خنجر سایه مرگ ابدی با کیفیت Epic. این آیتم در اعماق اقلیم قلمرو خلاء و سایه ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 45 مناسب است.	{"value": 6, "special_buff": "aura_abyss"}	67
item_volcanic_129	زره پولادی کوره سنگ جهنمی	Legendary	QuestItem	یک زره پولادی کوره سنگ جهنمی با کیفیت Legendary. این آیتم در اعماق اقلیم سرزمین‌های گدازه و خاکستر ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 46 مناسب است.	{"value": 3, "special_buff": "aura_volcanic"}	41
item_glacial_130	دستکش‌های منجمد یخبندان شمالی	Common	Weapon	یک دستکش‌های منجمد یخبندان شمالی با کیفیت Common. این آیتم در اعماق اقلیم دشت‌های منجمد شمالی ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 3 مناسب است.	{"damage": 94, "stat_bonus": "defense"}	87
item_arcane_131	عصای مانا اسرار باستانی	Uncommon	Armor	یک عصای مانا اسرار باستانی با کیفیت Uncommon. این آیتم در اعماق اقلیم ارگ ماورایی مانا ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 16 مناسب است.	{"defense": 54, "hp_bonus": 141}	21
item_abyss_132	حرز تاریکی خلاء	Rare	Potion	یک حرز تاریکی خلاء با کیفیت Rare. این آیتم در اعماق اقلیم قلمرو خلاء و سایه ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 41 مناسب است.	{"target": "hp", "restore_value": 335}	74
item_volcanic_133	زره پولادی کوره سنگ جهنمی	Epic	Relic	یک زره پولادی کوره سنگ جهنمی با کیفیت Epic. این آیتم در اعماق اقلیم سرزمین‌های گدازه و خاکستر ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 7 مناسب است.	{"value": 8, "special_buff": "aura_volcanic"}	91
item_glacial_134	کلاهخود بلورین یخبندان شمالی	Legendary	QuestItem	یک کلاهخود بلورین یخبندان شمالی با کیفیت Legendary. این آیتم در اعماق اقلیم دشت‌های منجمد شمالی ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 41 مناسب است.	{"value": 5, "special_buff": "aura_glacial"}	11
item_arcane_135	کتاب طلسمات کهن جادوی کهن	Common	Weapon	یک کتاب طلسمات کهن جادوی کهن با کیفیت Common. این آیتم در اعماق اقلیم ارگ ماورایی مانا ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 26 مناسب است.	{"damage": 47, "stat_bonus": "intelligence"}	22
item_abyss_136	عصای خلاء سایه‌های سرگردان	Uncommon	Armor	یک عصای خلاء سایه‌های سرگردان با کیفیت Uncommon. این آیتم در اعماق اقلیم قلمرو خلاء و سایه ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 47 مناسب است.	{"defense": 8, "hp_bonus": 28}	68
item_volcanic_137	حلقه خاکستر آتشفشان	Rare	Potion	یک حلقه خاکستر آتشفشان با کیفیت Rare. این آیتم در اعماق اقلیم سرزمین‌های گدازه و خاکستر ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 9 مناسب است.	{"target": "hp", "restore_value": 303}	81
item_glacial_138	طلسم زمستان یخبندان شمالی	Epic	Relic	یک طلسم زمستان یخبندان شمالی با کیفیت Epic. این آیتم در اعماق اقلیم دشت‌های منجمد شمالی ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 31 مناسب است.	{"value": 3, "special_buff": "aura_glacial"}	24
item_arcane_139	حلقه کیهانی اسرار باستانی	Legendary	QuestItem	یک حلقه کیهانی اسرار باستانی با کیفیت Legendary. این آیتم در اعماق اقلیم ارگ ماورایی مانا ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 16 مناسب است.	{"value": 1, "special_buff": "aura_arcane"}	47
item_abyss_140	عصای خلاء خلاء	Common	Weapon	یک عصای خلاء خلاء با کیفیت Common. این آیتم در اعماق اقلیم قلمرو خلاء و سایه ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 39 مناسب است.	{"damage": 66, "stat_bonus": "black_knowledge_level"}	55
item_volcanic_141	زره پولادی کوره آتش ابدی	Uncommon	Armor	یک زره پولادی کوره آتش ابدی با کیفیت Uncommon. این آیتم در اعماق اقلیم سرزمین‌های گدازه و خاکستر ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 18 مناسب است.	{"defense": 24, "hp_bonus": 143}	15
item_glacial_142	تبر یخی سرمای استخوان‌سوز	Rare	Potion	یک تبر یخی سرمای استخوان‌سوز با کیفیت Rare. این آیتم در اعماق اقلیم دشت‌های منجمد شمالی ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 20 مناسب است.	{"target": "hp", "restore_value": 304}	38
item_arcane_143	عصای مانا مانای سرکش	Epic	Relic	یک عصای مانا مانای سرکش با کیفیت Epic. این آیتم در اعماق اقلیم ارگ ماورایی مانا ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 48 مناسب است.	{"value": 7, "special_buff": "aura_arcane"}	91
item_abyss_144	زره روح سرگردان فاسد شده	Legendary	QuestItem	یک زره روح سرگردان فاسد شده با کیفیت Legendary. این آیتم در اعماق اقلیم قلمرو خلاء و سایه ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 40 مناسب است.	{"value": 8, "special_buff": "aura_abyss"}	69
item_volcanic_145	سپر آتشین آتشفشان	Common	Weapon	یک سپر آتشین آتشفشان با کیفیت Common. این آیتم در اعماق اقلیم سرزمین‌های گدازه و خاکستر ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 21 مناسب است.	{"damage": 62, "stat_bonus": "strength"}	41
item_glacial_146	طلسم زمستان یخبندان شمالی	Uncommon	Armor	یک طلسم زمستان یخبندان شمالی با کیفیت Uncommon. این آیتم در اعماق اقلیم دشت‌های منجمد شمالی ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 7 مناسب است.	{"defense": 28, "hp_bonus": 281}	67
item_arcane_147	حلقه کیهانی انرژی‌های کیهانی	Rare	Potion	یک حلقه کیهانی انرژی‌های کیهانی با کیفیت Rare. این آیتم در اعماق اقلیم ارگ ماورایی مانا ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 25 مناسب است.	{"target": "mana", "restore_value": 320}	11
item_abyss_148	خنجر سایه فاسد شده	Epic	Relic	یک خنجر سایه فاسد شده با کیفیت Epic. این آیتم در اعماق اقلیم قلمرو خلاء و سایه ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 16 مناسب است.	{"value": 3, "special_buff": "aura_abyss"}	67
item_volcanic_149	سپر آتشین سنگ جهنمی	Legendary	QuestItem	یک سپر آتشین سنگ جهنمی با کیفیت Legendary. این آیتم در اعماق اقلیم سرزمین‌های گدازه و خاکستر ساخته شده و قدرت‌های پنهان آن برای مبارزان سطح 18 مناسب است.	{"value": 9, "special_buff": "aura_volcanic"}	82
\.


--
-- Data for Name: location; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.location (location_id, name, danger_level, region_type, description) FROM stdin;
loc_abyss_000	شکاف سایه‌های سرگردان	67	Abyss	منطقه‌ای در قلمرو خلاء و سایه معروف به شکاف سایه‌های سرگردان. اتمسفر این مکان به شدت تحت تاثیر انرژی‌های Abyss است و سطح خطر آن 67 ارزیابی می‌شود.
loc_volcanic_001	دره سوزان آتشفشان	11	Volcanic	منطقه‌ای در سرزمین‌های گدازه و خاکستر معروف به دره سوزان آتشفشان. اتمسفر این مکان به شدت تحت تاثیر انرژی‌های Volcanic است و سطح خطر آن 11 ارزیابی می‌شود.
loc_glacial_002	قلعه منجمد زمستان تاریک	80	Glacial	منطقه‌ای در دشت‌های منجمد شمالی معروف به قلعه منجمد زمستان تاریک. اتمسفر این مکان به شدت تحت تاثیر انرژی‌های Glacial است و سطح خطر آن 80 ارزیابی می‌شود.
loc_arcane_003	تالار اسرار باستانی	19	Arcane	منطقه‌ای در ارگ ماورایی مانا معروف به تالار اسرار باستانی. اتمسفر این مکان به شدت تحت تاثیر انرژی‌های Arcane است و سطح خطر آن 19 ارزیابی می‌شود.
loc_abyss_004	شکاف ظلمت	17	Abyss	منطقه‌ای در قلمرو خلاء و سایه معروف به شکاف ظلمت. اتمسفر این مکان به شدت تحت تاثیر انرژی‌های Abyss است و سطح خطر آن 17 ارزیابی می‌شود.
loc_volcanic_005	دهانه سنگ جهنمی	94	Volcanic	منطقه‌ای در سرزمین‌های گدازه و خاکستر معروف به دهانه سنگ جهنمی. اتمسفر این مکان به شدت تحت تاثیر انرژی‌های Volcanic است و سطح خطر آن 94 ارزیابی می‌شود.
loc_glacial_006	غار بلورین زمستان تاریک	96	Glacial	منطقه‌ای در دشت‌های منجمد شمالی معروف به غار بلورین زمستان تاریک. اتمسفر این مکان به شدت تحت تاثیر انرژی‌های Glacial است و سطح خطر آن 96 ارزیابی می‌شود.
loc_arcane_007	باغ معلق جادوی کهن	31	Arcane	منطقه‌ای در ارگ ماورایی مانا معروف به باغ معلق جادوی کهن. اتمسفر این مکان به شدت تحت تاثیر انرژی‌های Arcane است و سطح خطر آن 31 ارزیابی می‌شود.
loc_abyss_008	سیاه‌چال ظلمت	16	Abyss	منطقه‌ای در قلمرو خلاء و سایه معروف به سیاه‌چال ظلمت. اتمسفر این مکان به شدت تحت تاثیر انرژی‌های Abyss است و سطح خطر آن 16 ارزیابی می‌شود.
loc_volcanic_009	دره سوزان آتش ابدی	61	Volcanic	منطقه‌ای در سرزمین‌های گدازه و خاکستر معروف به دره سوزان آتش ابدی. اتمسفر این مکان به شدت تحت تاثیر انرژی‌های Volcanic است و سطح خطر آن 61 ارزیابی می‌شود.
loc_glacial_010	گردنه بلورهای جادویی	72	Glacial	منطقه‌ای در دشت‌های منجمد شمالی معروف به گردنه بلورهای جادویی. اتمسفر این مکان به شدت تحت تاثیر انرژی‌های Glacial است و سطح خطر آن 72 ارزیابی می‌شود.
loc_arcane_011	باغ معلق انرژی‌های کیهانی	50	Arcane	منطقه‌ای در ارگ ماورایی مانا معروف به باغ معلق انرژی‌های کیهانی. اتمسفر این مکان به شدت تحت تاثیر انرژی‌های Arcane است و سطح خطر آن 50 ارزیابی می‌شود.
loc_abyss_012	گودال مرگ ابدی	49	Abyss	منطقه‌ای در قلمرو خلاء و سایه معروف به گودال مرگ ابدی. اتمسفر این مکان به شدت تحت تاثیر انرژی‌های Abyss است و سطح خطر آن 49 ارزیابی می‌شود.
loc_volcanic_013	دهانه سنگ جهنمی	97	Volcanic	منطقه‌ای در سرزمین‌های گدازه و خاکستر معروف به دهانه سنگ جهنمی. اتمسفر این مکان به شدت تحت تاثیر انرژی‌های Volcanic است و سطح خطر آن 97 ارزیابی می‌شود.
loc_glacial_014	غار بلورین سرمای استخوان‌سوز	44	Glacial	منطقه‌ای در دشت‌های منجمد شمالی معروف به غار بلورین سرمای استخوان‌سوز. اتمسفر این مکان به شدت تحت تاثیر انرژی‌های Glacial است و سطح خطر آن 44 ارزیابی می‌شود.
loc_arcane_015	مارپیچ اسرار باستانی	77	Arcane	منطقه‌ای در ارگ ماورایی مانا معروف به مارپیچ اسرار باستانی. اتمسفر این مکان به شدت تحت تاثیر انرژی‌های Arcane است و سطح خطر آن 77 ارزیابی می‌شود.
loc_abyss_016	سیاه‌چال ظلمت	52	Abyss	منطقه‌ای در قلمرو خلاء و سایه معروف به سیاه‌چال ظلمت. اتمسفر این مکان به شدت تحت تاثیر انرژی‌های Abyss است و سطح خطر آن 52 ارزیابی می‌شود.
loc_volcanic_017	قله آتش ابدی	54	Volcanic	منطقه‌ای در سرزمین‌های گدازه و خاکستر معروف به قله آتش ابدی. اتمسفر این مکان به شدت تحت تاثیر انرژی‌های Volcanic است و سطح خطر آن 54 ارزیابی می‌شود.
loc_glacial_018	پناهگاه یخبندان شمالی	32	Glacial	منطقه‌ای در دشت‌های منجمد شمالی معروف به پناهگاه یخبندان شمالی. اتمسفر این مکان به شدت تحت تاثیر انرژی‌های Glacial است و سطح خطر آن 32 ارزیابی می‌شود.
loc_arcane_019	کتابخانه اسرار باستانی	26	Arcane	منطقه‌ای در ارگ ماورایی مانا معروف به کتابخانه اسرار باستانی. اتمسفر این مکان به شدت تحت تاثیر انرژی‌های Arcane است و سطح خطر آن 26 ارزیابی می‌شود.
loc_abyss_020	معبد تاریک خلاء	98	Abyss	منطقه‌ای در قلمرو خلاء و سایه معروف به معبد تاریک خلاء. اتمسفر این مکان به شدت تحت تاثیر انرژی‌های Abyss است و سطح خطر آن 98 ارزیابی می‌شود.
loc_volcanic_021	دهانه آتش ابدی	86	Volcanic	منطقه‌ای در سرزمین‌های گدازه و خاکستر معروف به دهانه آتش ابدی. اتمسفر این مکان به شدت تحت تاثیر انرژی‌های Volcanic است و سطح خطر آن 86 ارزیابی می‌شود.
loc_glacial_022	پناهگاه کولاک ابدی	65	Glacial	منطقه‌ای در دشت‌های منجمد شمالی معروف به پناهگاه کولاک ابدی. اتمسفر این مکان به شدت تحت تاثیر انرژی‌های Glacial است و سطح خطر آن 65 ارزیابی می‌شود.
loc_arcane_023	برج جادوی کهن	95	Arcane	منطقه‌ای در ارگ ماورایی مانا معروف به برج جادوی کهن. اتمسفر این مکان به شدت تحت تاثیر انرژی‌های Arcane است و سطح خطر آن 95 ارزیابی می‌شود.
loc_abyss_024	گودال خلاء	38	Abyss	منطقه‌ای در قلمرو خلاء و سایه معروف به گودال خلاء. اتمسفر این مکان به شدت تحت تاثیر انرژی‌های Abyss است و سطح خطر آن 38 ارزیابی می‌شود.
loc_volcanic_025	دژ آهنین گدازه مذاب	100	Volcanic	منطقه‌ای در سرزمین‌های گدازه و خاکستر معروف به دژ آهنین گدازه مذاب. اتمسفر این مکان به شدت تحت تاثیر انرژی‌های Volcanic است و سطح خطر آن 100 ارزیابی می‌شود.
loc_glacial_026	گردنه یخبندان شمالی	42	Glacial	منطقه‌ای در دشت‌های منجمد شمالی معروف به گردنه یخبندان شمالی. اتمسفر این مکان به شدت تحت تاثیر انرژی‌های Glacial است و سطح خطر آن 42 ارزیابی می‌شود.
loc_arcane_027	مارپیچ ستاره‌شناسان	88	Arcane	منطقه‌ای در ارگ ماورایی مانا معروف به مارپیچ ستاره‌شناسان. اتمسفر این مکان به شدت تحت تاثیر انرژی‌های Arcane است و سطح خطر آن 88 ارزیابی می‌شود.
loc_abyss_028	معبد تاریک ظلمت	64	Abyss	منطقه‌ای در قلمرو خلاء و سایه معروف به معبد تاریک ظلمت. اتمسفر این مکان به شدت تحت تاثیر انرژی‌های Abyss است و سطح خطر آن 64 ارزیابی می‌شود.
loc_volcanic_029	کوره سنگ جهنمی	63	Volcanic	منطقه‌ای در سرزمین‌های گدازه و خاکستر معروف به کوره سنگ جهنمی. اتمسفر این مکان به شدت تحت تاثیر انرژی‌های Volcanic است و سطح خطر آن 63 ارزیابی می‌شود.
loc_glacial_030	گردنه سرمای استخوان‌سوز	78	Glacial	منطقه‌ای در دشت‌های منجمد شمالی معروف به گردنه سرمای استخوان‌سوز. اتمسفر این مکان به شدت تحت تاثیر انرژی‌های Glacial است و سطح خطر آن 78 ارزیابی می‌شود.
loc_arcane_031	تالار انرژی‌های کیهانی	89	Arcane	منطقه‌ای در ارگ ماورایی مانا معروف به تالار انرژی‌های کیهانی. اتمسفر این مکان به شدت تحت تاثیر انرژی‌های Arcane است و سطح خطر آن 89 ارزیابی می‌شود.
loc_abyss_032	گودال مرگ ابدی	61	Abyss	منطقه‌ای در قلمرو خلاء و سایه معروف به گودال مرگ ابدی. اتمسفر این مکان به شدت تحت تاثیر انرژی‌های Abyss است و سطح خطر آن 61 ارزیابی می‌شود.
loc_volcanic_033	قله سنگ جهنمی	13	Volcanic	منطقه‌ای در سرزمین‌های گدازه و خاکستر معروف به قله سنگ جهنمی. اتمسفر این مکان به شدت تحت تاثیر انرژی‌های Volcanic است و سطح خطر آن 13 ارزیابی می‌شود.
loc_glacial_034	پناهگاه زمستان تاریک	25	Glacial	منطقه‌ای در دشت‌های منجمد شمالی معروف به پناهگاه زمستان تاریک. اتمسفر این مکان به شدت تحت تاثیر انرژی‌های Glacial است و سطح خطر آن 25 ارزیابی می‌شود.
loc_arcane_035	تالار انرژی‌های کیهانی	45	Arcane	منطقه‌ای در ارگ ماورایی مانا معروف به تالار انرژی‌های کیهانی. اتمسفر این مکان به شدت تحت تاثیر انرژی‌های Arcane است و سطح خطر آن 45 ارزیابی می‌شود.
loc_abyss_036	گودال خلاء	53	Abyss	منطقه‌ای در قلمرو خلاء و سایه معروف به گودال خلاء. اتمسفر این مکان به شدت تحت تاثیر انرژی‌های Abyss است و سطح خطر آن 53 ارزیابی می‌شود.
loc_volcanic_037	قله گدازه مذاب	41	Volcanic	منطقه‌ای در سرزمین‌های گدازه و خاکستر معروف به قله گدازه مذاب. اتمسفر این مکان به شدت تحت تاثیر انرژی‌های Volcanic است و سطح خطر آن 41 ارزیابی می‌شود.
loc_glacial_038	گردنه زمستان تاریک	36	Glacial	منطقه‌ای در دشت‌های منجمد شمالی معروف به گردنه زمستان تاریک. اتمسفر این مکان به شدت تحت تاثیر انرژی‌های Glacial است و سطح خطر آن 36 ارزیابی می‌شود.
loc_arcane_039	تالار اسرار باستانی	71	Arcane	منطقه‌ای در ارگ ماورایی مانا معروف به تالار اسرار باستانی. اتمسفر این مکان به شدت تحت تاثیر انرژی‌های Arcane است و سطح خطر آن 71 ارزیابی می‌شود.
loc_abyss_040	شکاف خلاء	87	Abyss	منطقه‌ای در قلمرو خلاء و سایه معروف به شکاف خلاء. اتمسفر این مکان به شدت تحت تاثیر انرژی‌های Abyss است و سطح خطر آن 87 ارزیابی می‌شود.
loc_volcanic_041	کوره سنگ جهنمی	48	Volcanic	منطقه‌ای در سرزمین‌های گدازه و خاکستر معروف به کوره سنگ جهنمی. اتمسفر این مکان به شدت تحت تاثیر انرژی‌های Volcanic است و سطح خطر آن 48 ارزیابی می‌شود.
loc_glacial_042	پناهگاه یخبندان شمالی	53	Glacial	منطقه‌ای در دشت‌های منجمد شمالی معروف به پناهگاه یخبندان شمالی. اتمسفر این مکان به شدت تحت تاثیر انرژی‌های Glacial است و سطح خطر آن 53 ارزیابی می‌شود.
loc_arcane_043	تالار جادوی کهن	76	Arcane	منطقه‌ای در ارگ ماورایی مانا معروف به تالار جادوی کهن. اتمسفر این مکان به شدت تحت تاثیر انرژی‌های Arcane است و سطح خطر آن 76 ارزیابی می‌شود.
loc_abyss_044	معبد تاریک ظلمت	79	Abyss	منطقه‌ای در قلمرو خلاء و سایه معروف به معبد تاریک ظلمت. اتمسفر این مکان به شدت تحت تاثیر انرژی‌های Abyss است و سطح خطر آن 79 ارزیابی می‌شود.
loc_volcanic_045	کوره آتش ابدی	21	Volcanic	منطقه‌ای در سرزمین‌های گدازه و خاکستر معروف به کوره آتش ابدی. اتمسفر این مکان به شدت تحت تاثیر انرژی‌های Volcanic است و سطح خطر آن 21 ارزیابی می‌شود.
loc_glacial_046	دشت یخ‌زده کولاک ابدی	18	Glacial	منطقه‌ای در دشت‌های منجمد شمالی معروف به دشت یخ‌زده کولاک ابدی. اتمسفر این مکان به شدت تحت تاثیر انرژی‌های Glacial است و سطح خطر آن 18 ارزیابی می‌شود.
loc_arcane_047	کتابخانه انرژی‌های کیهانی	42	Arcane	منطقه‌ای در ارگ ماورایی مانا معروف به کتابخانه انرژی‌های کیهانی. اتمسفر این مکان به شدت تحت تاثیر انرژی‌های Arcane است و سطح خطر آن 42 ارزیابی می‌شود.
loc_abyss_048	دره خاموش ظلمت	69	Abyss	منطقه‌ای در قلمرو خلاء و سایه معروف به دره خاموش ظلمت. اتمسفر این مکان به شدت تحت تاثیر انرژی‌های Abyss است و سطح خطر آن 69 ارزیابی می‌شود.
loc_volcanic_049	دژ آهنین آتشفشان	94	Volcanic	منطقه‌ای در سرزمین‌های گدازه و خاکستر معروف به دژ آهنین آتشفشان. اتمسفر این مکان به شدت تحت تاثیر انرژی‌های Volcanic است و سطح خطر آن 94 ارزیابی می‌شود.
loc_glacial_050	غار بلورین کولاک ابدی	81	Glacial	منطقه‌ای در دشت‌های منجمد شمالی معروف به غار بلورین کولاک ابدی. اتمسفر این مکان به شدت تحت تاثیر انرژی‌های Glacial است و سطح خطر آن 81 ارزیابی می‌شود.
loc_arcane_051	تالار انرژی‌های کیهانی	75	Arcane	منطقه‌ای در ارگ ماورایی مانا معروف به تالار انرژی‌های کیهانی. اتمسفر این مکان به شدت تحت تاثیر انرژی‌های Arcane است و سطح خطر آن 75 ارزیابی می‌شود.
loc_abyss_052	شکاف سایه‌های سرگردان	84	Abyss	منطقه‌ای در قلمرو خلاء و سایه معروف به شکاف سایه‌های سرگردان. اتمسفر این مکان به شدت تحت تاثیر انرژی‌های Abyss است و سطح خطر آن 84 ارزیابی می‌شود.
loc_volcanic_053	قله آتشفشان	98	Volcanic	منطقه‌ای در سرزمین‌های گدازه و خاکستر معروف به قله آتشفشان. اتمسفر این مکان به شدت تحت تاثیر انرژی‌های Volcanic است و سطح خطر آن 98 ارزیابی می‌شود.
loc_glacial_054	گردنه بلورهای جادویی	94	Glacial	منطقه‌ای در دشت‌های منجمد شمالی معروف به گردنه بلورهای جادویی. اتمسفر این مکان به شدت تحت تاثیر انرژی‌های Glacial است و سطح خطر آن 94 ارزیابی می‌شود.
loc_arcane_055	کتابخانه ستاره‌شناسان	88	Arcane	منطقه‌ای در ارگ ماورایی مانا معروف به کتابخانه ستاره‌شناسان. اتمسفر این مکان به شدت تحت تاثیر انرژی‌های Arcane است و سطح خطر آن 88 ارزیابی می‌شود.
loc_abyss_056	گودال فاسد شده	57	Abyss	منطقه‌ای در قلمرو خلاء و سایه معروف به گودال فاسد شده. اتمسفر این مکان به شدت تحت تاثیر انرژی‌های Abyss است و سطح خطر آن 57 ارزیابی می‌شود.
loc_volcanic_057	کوره آتش ابدی	24	Volcanic	منطقه‌ای در سرزمین‌های گدازه و خاکستر معروف به کوره آتش ابدی. اتمسفر این مکان به شدت تحت تاثیر انرژی‌های Volcanic است و سطح خطر آن 24 ارزیابی می‌شود.
loc_glacial_058	غار بلورین کولاک ابدی	18	Glacial	منطقه‌ای در دشت‌های منجمد شمالی معروف به غار بلورین کولاک ابدی. اتمسفر این مکان به شدت تحت تاثیر انرژی‌های Glacial است و سطح خطر آن 18 ارزیابی می‌شود.
loc_arcane_059	کتابخانه مانای سرکش	95	Arcane	منطقه‌ای در ارگ ماورایی مانا معروف به کتابخانه مانای سرکش. اتمسفر این مکان به شدت تحت تاثیر انرژی‌های Arcane است و سطح خطر آن 95 ارزیابی می‌شود.
loc_abyss_060	سیاه‌چال ظلمت	79	Abyss	منطقه‌ای در قلمرو خلاء و سایه معروف به سیاه‌چال ظلمت. اتمسفر این مکان به شدت تحت تاثیر انرژی‌های Abyss است و سطح خطر آن 79 ارزیابی می‌شود.
loc_volcanic_061	کوره آتش ابدی	43	Volcanic	منطقه‌ای در سرزمین‌های گدازه و خاکستر معروف به کوره آتش ابدی. اتمسفر این مکان به شدت تحت تاثیر انرژی‌های Volcanic است و سطح خطر آن 43 ارزیابی می‌شود.
loc_glacial_062	قلعه منجمد بلورهای جادویی	19	Glacial	منطقه‌ای در دشت‌های منجمد شمالی معروف به قلعه منجمد بلورهای جادویی. اتمسفر این مکان به شدت تحت تاثیر انرژی‌های Glacial است و سطح خطر آن 19 ارزیابی می‌شود.
loc_arcane_063	برج مانای سرکش	19	Arcane	منطقه‌ای در ارگ ماورایی مانا معروف به برج مانای سرکش. اتمسفر این مکان به شدت تحت تاثیر انرژی‌های Arcane است و سطح خطر آن 19 ارزیابی می‌شود.
loc_abyss_064	معبد تاریک سایه‌های سرگردان	80	Abyss	منطقه‌ای در قلمرو خلاء و سایه معروف به معبد تاریک سایه‌های سرگردان. اتمسفر این مکان به شدت تحت تاثیر انرژی‌های Abyss است و سطح خطر آن 80 ارزیابی می‌شود.
loc_volcanic_065	دژ آهنین سنگ جهنمی	52	Volcanic	منطقه‌ای در سرزمین‌های گدازه و خاکستر معروف به دژ آهنین سنگ جهنمی. اتمسفر این مکان به شدت تحت تاثیر انرژی‌های Volcanic است و سطح خطر آن 52 ارزیابی می‌شود.
loc_glacial_066	گردنه کولاک ابدی	10	Glacial	منطقه‌ای در دشت‌های منجمد شمالی معروف به گردنه کولاک ابدی. اتمسفر این مکان به شدت تحت تاثیر انرژی‌های Glacial است و سطح خطر آن 10 ارزیابی می‌شود.
loc_arcane_067	کتابخانه مانای سرکش	24	Arcane	منطقه‌ای در ارگ ماورایی مانا معروف به کتابخانه مانای سرکش. اتمسفر این مکان به شدت تحت تاثیر انرژی‌های Arcane است و سطح خطر آن 24 ارزیابی می‌شود.
loc_abyss_068	گودال سایه‌های سرگردان	50	Abyss	منطقه‌ای در قلمرو خلاء و سایه معروف به گودال سایه‌های سرگردان. اتمسفر این مکان به شدت تحت تاثیر انرژی‌های Abyss است و سطح خطر آن 50 ارزیابی می‌شود.
loc_volcanic_069	قله خاکستر سرخ	65	Volcanic	منطقه‌ای در سرزمین‌های گدازه و خاکستر معروف به قله خاکستر سرخ. اتمسفر این مکان به شدت تحت تاثیر انرژی‌های Volcanic است و سطح خطر آن 65 ارزیابی می‌شود.
loc_glacial_070	غار بلورین بلورهای جادویی	68	Glacial	منطقه‌ای در دشت‌های منجمد شمالی معروف به غار بلورین بلورهای جادویی. اتمسفر این مکان به شدت تحت تاثیر انرژی‌های Glacial است و سطح خطر آن 68 ارزیابی می‌شود.
loc_arcane_071	مارپیچ ستاره‌شناسان	99	Arcane	منطقه‌ای در ارگ ماورایی مانا معروف به مارپیچ ستاره‌شناسان. اتمسفر این مکان به شدت تحت تاثیر انرژی‌های Arcane است و سطح خطر آن 99 ارزیابی می‌شود.
loc_abyss_072	گودال خلاء	86	Abyss	منطقه‌ای در قلمرو خلاء و سایه معروف به گودال خلاء. اتمسفر این مکان به شدت تحت تاثیر انرژی‌های Abyss است و سطح خطر آن 86 ارزیابی می‌شود.
loc_volcanic_073	دره سوزان آتشفشان	68	Volcanic	منطقه‌ای در سرزمین‌های گدازه و خاکستر معروف به دره سوزان آتشفشان. اتمسفر این مکان به شدت تحت تاثیر انرژی‌های Volcanic است و سطح خطر آن 68 ارزیابی می‌شود.
loc_glacial_074	دشت یخ‌زده سرمای استخوان‌سوز	14	Glacial	منطقه‌ای در دشت‌های منجمد شمالی معروف به دشت یخ‌زده سرمای استخوان‌سوز. اتمسفر این مکان به شدت تحت تاثیر انرژی‌های Glacial است و سطح خطر آن 14 ارزیابی می‌شود.
loc_arcane_075	مارپیچ ستاره‌شناسان	46	Arcane	منطقه‌ای در ارگ ماورایی مانا معروف به مارپیچ ستاره‌شناسان. اتمسفر این مکان به شدت تحت تاثیر انرژی‌های Arcane است و سطح خطر آن 46 ارزیابی می‌شود.
loc_abyss_076	سیاه‌چال فاسد شده	13	Abyss	منطقه‌ای در قلمرو خلاء و سایه معروف به سیاه‌چال فاسد شده. اتمسفر این مکان به شدت تحت تاثیر انرژی‌های Abyss است و سطح خطر آن 13 ارزیابی می‌شود.
loc_volcanic_077	دژ آهنین سنگ جهنمی	13	Volcanic	منطقه‌ای در سرزمین‌های گدازه و خاکستر معروف به دژ آهنین سنگ جهنمی. اتمسفر این مکان به شدت تحت تاثیر انرژی‌های Volcanic است و سطح خطر آن 13 ارزیابی می‌شود.
loc_glacial_078	غار بلورین سرمای استخوان‌سوز	95	Glacial	منطقه‌ای در دشت‌های منجمد شمالی معروف به غار بلورین سرمای استخوان‌سوز. اتمسفر این مکان به شدت تحت تاثیر انرژی‌های Glacial است و سطح خطر آن 95 ارزیابی می‌شود.
loc_arcane_079	برج مانای سرکش	46	Arcane	منطقه‌ای در ارگ ماورایی مانا معروف به برج مانای سرکش. اتمسفر این مکان به شدت تحت تاثیر انرژی‌های Arcane است و سطح خطر آن 46 ارزیابی می‌شود.
loc_abyss_080	سیاه‌چال خلاء	92	Abyss	منطقه‌ای در قلمرو خلاء و سایه معروف به سیاه‌چال خلاء. اتمسفر این مکان به شدت تحت تاثیر انرژی‌های Abyss است و سطح خطر آن 92 ارزیابی می‌شود.
loc_volcanic_081	دژ آهنین سنگ جهنمی	69	Volcanic	منطقه‌ای در سرزمین‌های گدازه و خاکستر معروف به دژ آهنین سنگ جهنمی. اتمسفر این مکان به شدت تحت تاثیر انرژی‌های Volcanic است و سطح خطر آن 69 ارزیابی می‌شود.
loc_glacial_082	قلعه منجمد کولاک ابدی	15	Glacial	منطقه‌ای در دشت‌های منجمد شمالی معروف به قلعه منجمد کولاک ابدی. اتمسفر این مکان به شدت تحت تاثیر انرژی‌های Glacial است و سطح خطر آن 15 ارزیابی می‌شود.
loc_arcane_083	مارپیچ جادوی کهن	42	Arcane	منطقه‌ای در ارگ ماورایی مانا معروف به مارپیچ جادوی کهن. اتمسفر این مکان به شدت تحت تاثیر انرژی‌های Arcane است و سطح خطر آن 42 ارزیابی می‌شود.
loc_abyss_084	معبد تاریک مرگ ابدی	23	Abyss	منطقه‌ای در قلمرو خلاء و سایه معروف به معبد تاریک مرگ ابدی. اتمسفر این مکان به شدت تحت تاثیر انرژی‌های Abyss است و سطح خطر آن 23 ارزیابی می‌شود.
loc_volcanic_085	دره سوزان آتشفشان	39	Volcanic	منطقه‌ای در سرزمین‌های گدازه و خاکستر معروف به دره سوزان آتشفشان. اتمسفر این مکان به شدت تحت تاثیر انرژی‌های Volcanic است و سطح خطر آن 39 ارزیابی می‌شود.
loc_glacial_086	پناهگاه سرمای استخوان‌سوز	16	Glacial	منطقه‌ای در دشت‌های منجمد شمالی معروف به پناهگاه سرمای استخوان‌سوز. اتمسفر این مکان به شدت تحت تاثیر انرژی‌های Glacial است و سطح خطر آن 16 ارزیابی می‌شود.
loc_arcane_087	برج مانای سرکش	96	Arcane	منطقه‌ای در ارگ ماورایی مانا معروف به برج مانای سرکش. اتمسفر این مکان به شدت تحت تاثیر انرژی‌های Arcane است و سطح خطر آن 96 ارزیابی می‌شود.
loc_abyss_088	دره خاموش مرگ ابدی	16	Abyss	منطقه‌ای در قلمرو خلاء و سایه معروف به دره خاموش مرگ ابدی. اتمسفر این مکان به شدت تحت تاثیر انرژی‌های Abyss است و سطح خطر آن 16 ارزیابی می‌شود.
loc_volcanic_089	دره سوزان گدازه مذاب	80	Volcanic	منطقه‌ای در سرزمین‌های گدازه و خاکستر معروف به دره سوزان گدازه مذاب. اتمسفر این مکان به شدت تحت تاثیر انرژی‌های Volcanic است و سطح خطر آن 80 ارزیابی می‌شود.
loc_glacial_090	غار بلورین کولاک ابدی	39	Glacial	منطقه‌ای در دشت‌های منجمد شمالی معروف به غار بلورین کولاک ابدی. اتمسفر این مکان به شدت تحت تاثیر انرژی‌های Glacial است و سطح خطر آن 39 ارزیابی می‌شود.
loc_arcane_091	مارپیچ اسرار باستانی	39	Arcane	منطقه‌ای در ارگ ماورایی مانا معروف به مارپیچ اسرار باستانی. اتمسفر این مکان به شدت تحت تاثیر انرژی‌های Arcane است و سطح خطر آن 39 ارزیابی می‌شود.
loc_abyss_092	گودال فاسد شده	83	Abyss	منطقه‌ای در قلمرو خلاء و سایه معروف به گودال فاسد شده. اتمسفر این مکان به شدت تحت تاثیر انرژی‌های Abyss است و سطح خطر آن 83 ارزیابی می‌شود.
loc_volcanic_093	قله آتش ابدی	27	Volcanic	منطقه‌ای در سرزمین‌های گدازه و خاکستر معروف به قله آتش ابدی. اتمسفر این مکان به شدت تحت تاثیر انرژی‌های Volcanic است و سطح خطر آن 27 ارزیابی می‌شود.
loc_glacial_094	گردنه بلورهای جادویی	57	Glacial	منطقه‌ای در دشت‌های منجمد شمالی معروف به گردنه بلورهای جادویی. اتمسفر این مکان به شدت تحت تاثیر انرژی‌های Glacial است و سطح خطر آن 57 ارزیابی می‌شود.
loc_arcane_095	کتابخانه جادوی کهن	93	Arcane	منطقه‌ای در ارگ ماورایی مانا معروف به کتابخانه جادوی کهن. اتمسفر این مکان به شدت تحت تاثیر انرژی‌های Arcane است و سطح خطر آن 93 ارزیابی می‌شود.
loc_abyss_096	گودال مرگ ابدی	82	Abyss	منطقه‌ای در قلمرو خلاء و سایه معروف به گودال مرگ ابدی. اتمسفر این مکان به شدت تحت تاثیر انرژی‌های Abyss است و سطح خطر آن 82 ارزیابی می‌شود.
loc_volcanic_097	دژ آهنین آتشفشان	12	Volcanic	منطقه‌ای در سرزمین‌های گدازه و خاکستر معروف به دژ آهنین آتشفشان. اتمسفر این مکان به شدت تحت تاثیر انرژی‌های Volcanic است و سطح خطر آن 12 ارزیابی می‌شود.
loc_glacial_098	غار بلورین سرمای استخوان‌سوز	99	Glacial	منطقه‌ای در دشت‌های منجمد شمالی معروف به غار بلورین سرمای استخوان‌سوز. اتمسفر این مکان به شدت تحت تاثیر انرژی‌های Glacial است و سطح خطر آن 99 ارزیابی می‌شود.
loc_arcane_099	کتابخانه جادوی کهن	36	Arcane	منطقه‌ای در ارگ ماورایی مانا معروف به کتابخانه جادوی کهن. اتمسفر این مکان به شدت تحت تاثیر انرژی‌های Arcane است و سطح خطر آن 36 ارزیابی می‌شود.
\.


--
-- Data for Name: location_feature; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.location_feature (feature_id, location_id, name, rarity, effect_json, effect_region, weight) FROM stdin;
feat_loc_abyss_000	loc_abyss_000	هاله قلمرو خلاء و سایه	Rare	{"value": 1.33, "stat_modifier": "black_knowledge_level"}	Global	46
feat_loc_volcanic_001	loc_volcanic_001	هاله سرزمین‌های گدازه و خاکستر	Common	{"value": 1.05, "stat_modifier": "strength"}	Global	65
feat_loc_glacial_002	loc_glacial_002	هاله دشت‌های منجمد شمالی	Epic	{"value": 1.4, "stat_modifier": "defense"}	Global	80
feat_loc_arcane_003	loc_arcane_003	هاله ارگ ماورایی مانا	Rare	{"value": 1.09, "stat_modifier": "intelligence"}	Global	94
feat_loc_abyss_004	loc_abyss_004	هاله قلمرو خلاء و سایه	Legendary	{"value": 1.08, "stat_modifier": "black_knowledge_level"}	Global	53
feat_loc_volcanic_005	loc_volcanic_005	هاله سرزمین‌های گدازه و خاکستر	Legendary	{"value": 1.47, "stat_modifier": "strength"}	Global	99
feat_loc_glacial_006	loc_glacial_006	هاله دشت‌های منجمد شمالی	Legendary	{"value": 1.48, "stat_modifier": "defense"}	Global	40
feat_loc_arcane_007	loc_arcane_007	هاله ارگ ماورایی مانا	Rare	{"value": 1.16, "stat_modifier": "intelligence"}	Global	42
feat_loc_abyss_008	loc_abyss_008	هاله قلمرو خلاء و سایه	Rare	{"value": 1.08, "stat_modifier": "black_knowledge_level"}	Global	34
feat_loc_volcanic_009	loc_volcanic_009	هاله سرزمین‌های گدازه و خاکستر	Legendary	{"value": 1.3, "stat_modifier": "strength"}	Global	26
feat_loc_glacial_010	loc_glacial_010	هاله دشت‌های منجمد شمالی	Common	{"value": 1.36, "stat_modifier": "defense"}	Global	51
feat_loc_arcane_011	loc_arcane_011	هاله ارگ ماورایی مانا	Common	{"value": 1.25, "stat_modifier": "intelligence"}	Global	45
feat_loc_abyss_012	loc_abyss_012	هاله قلمرو خلاء و سایه	Common	{"value": 1.25, "stat_modifier": "black_knowledge_level"}	Global	80
feat_loc_volcanic_013	loc_volcanic_013	هاله سرزمین‌های گدازه و خاکستر	Legendary	{"value": 1.48, "stat_modifier": "strength"}	Global	15
feat_loc_glacial_014	loc_glacial_014	هاله دشت‌های منجمد شمالی	Legendary	{"value": 1.22, "stat_modifier": "defense"}	Global	14
feat_loc_arcane_015	loc_arcane_015	هاله ارگ ماورایی مانا	Common	{"value": 1.39, "stat_modifier": "intelligence"}	Global	77
feat_loc_abyss_016	loc_abyss_016	هاله قلمرو خلاء و سایه	Common	{"value": 1.26, "stat_modifier": "black_knowledge_level"}	Global	15
feat_loc_volcanic_017	loc_volcanic_017	هاله سرزمین‌های گدازه و خاکستر	Legendary	{"value": 1.27, "stat_modifier": "strength"}	Global	75
feat_loc_glacial_018	loc_glacial_018	هاله دشت‌های منجمد شمالی	Legendary	{"value": 1.16, "stat_modifier": "defense"}	Global	70
feat_loc_arcane_019	loc_arcane_019	هاله ارگ ماورایی مانا	Rare	{"value": 1.13, "stat_modifier": "intelligence"}	Global	33
feat_loc_abyss_020	loc_abyss_020	هاله قلمرو خلاء و سایه	Rare	{"value": 1.49, "stat_modifier": "black_knowledge_level"}	Global	90
feat_loc_volcanic_021	loc_volcanic_021	هاله سرزمین‌های گدازه و خاکستر	Common	{"value": 1.43, "stat_modifier": "strength"}	Global	12
feat_loc_glacial_022	loc_glacial_022	هاله دشت‌های منجمد شمالی	Epic	{"value": 1.32, "stat_modifier": "defense"}	Global	12
feat_loc_arcane_023	loc_arcane_023	هاله ارگ ماورایی مانا	Rare	{"value": 1.48, "stat_modifier": "intelligence"}	Global	73
feat_loc_abyss_024	loc_abyss_024	هاله قلمرو خلاء و سایه	Legendary	{"value": 1.19, "stat_modifier": "black_knowledge_level"}	Global	18
feat_loc_volcanic_025	loc_volcanic_025	هاله سرزمین‌های گدازه و خاکستر	Epic	{"value": 1.5, "stat_modifier": "strength"}	Global	65
feat_loc_glacial_026	loc_glacial_026	هاله دشت‌های منجمد شمالی	Common	{"value": 1.21, "stat_modifier": "defense"}	Global	53
feat_loc_arcane_027	loc_arcane_027	هاله ارگ ماورایی مانا	Rare	{"value": 1.44, "stat_modifier": "intelligence"}	Global	97
feat_loc_abyss_028	loc_abyss_028	هاله قلمرو خلاء و سایه	Rare	{"value": 1.32, "stat_modifier": "black_knowledge_level"}	Global	38
feat_loc_volcanic_029	loc_volcanic_029	هاله سرزمین‌های گدازه و خاکستر	Common	{"value": 1.31, "stat_modifier": "strength"}	Global	36
feat_loc_glacial_030	loc_glacial_030	هاله دشت‌های منجمد شمالی	Legendary	{"value": 1.39, "stat_modifier": "defense"}	Global	19
feat_loc_arcane_031	loc_arcane_031	هاله ارگ ماورایی مانا	Epic	{"value": 1.45, "stat_modifier": "intelligence"}	Global	22
feat_loc_abyss_032	loc_abyss_032	هاله قلمرو خلاء و سایه	Epic	{"value": 1.3, "stat_modifier": "black_knowledge_level"}	Global	46
feat_loc_volcanic_033	loc_volcanic_033	هاله سرزمین‌های گدازه و خاکستر	Epic	{"value": 1.06, "stat_modifier": "strength"}	Global	38
feat_loc_glacial_034	loc_glacial_034	هاله دشت‌های منجمد شمالی	Epic	{"value": 1.12, "stat_modifier": "defense"}	Global	72
feat_loc_arcane_035	loc_arcane_035	هاله ارگ ماورایی مانا	Legendary	{"value": 1.23, "stat_modifier": "intelligence"}	Global	89
feat_loc_abyss_036	loc_abyss_036	هاله قلمرو خلاء و سایه	Legendary	{"value": 1.27, "stat_modifier": "black_knowledge_level"}	Global	90
feat_loc_volcanic_037	loc_volcanic_037	هاله سرزمین‌های گدازه و خاکستر	Common	{"value": 1.21, "stat_modifier": "strength"}	Global	87
feat_loc_glacial_038	loc_glacial_038	هاله دشت‌های منجمد شمالی	Rare	{"value": 1.18, "stat_modifier": "defense"}	Global	61
feat_loc_arcane_039	loc_arcane_039	هاله ارگ ماورایی مانا	Common	{"value": 1.35, "stat_modifier": "intelligence"}	Global	90
feat_loc_abyss_040	loc_abyss_040	هاله قلمرو خلاء و سایه	Common	{"value": 1.44, "stat_modifier": "black_knowledge_level"}	Global	71
feat_loc_volcanic_041	loc_volcanic_041	هاله سرزمین‌های گدازه و خاکستر	Common	{"value": 1.24, "stat_modifier": "strength"}	Global	38
feat_loc_glacial_042	loc_glacial_042	هاله دشت‌های منجمد شمالی	Rare	{"value": 1.27, "stat_modifier": "defense"}	Global	27
feat_loc_arcane_043	loc_arcane_043	هاله ارگ ماورایی مانا	Epic	{"value": 1.38, "stat_modifier": "intelligence"}	Global	52
feat_loc_abyss_044	loc_abyss_044	هاله قلمرو خلاء و سایه	Rare	{"value": 1.4, "stat_modifier": "black_knowledge_level"}	Global	89
feat_loc_volcanic_045	loc_volcanic_045	هاله سرزمین‌های گدازه و خاکستر	Epic	{"value": 1.1, "stat_modifier": "strength"}	Global	80
feat_loc_glacial_046	loc_glacial_046	هاله دشت‌های منجمد شمالی	Rare	{"value": 1.09, "stat_modifier": "defense"}	Global	17
feat_loc_arcane_047	loc_arcane_047	هاله ارگ ماورایی مانا	Common	{"value": 1.21, "stat_modifier": "intelligence"}	Global	89
feat_loc_abyss_048	loc_abyss_048	هاله قلمرو خلاء و سایه	Legendary	{"value": 1.34, "stat_modifier": "black_knowledge_level"}	Global	20
feat_loc_volcanic_049	loc_volcanic_049	هاله سرزمین‌های گدازه و خاکستر	Common	{"value": 1.47, "stat_modifier": "strength"}	Global	68
feat_loc_glacial_050	loc_glacial_050	هاله دشت‌های منجمد شمالی	Common	{"value": 1.41, "stat_modifier": "defense"}	Global	66
feat_loc_arcane_051	loc_arcane_051	هاله ارگ ماورایی مانا	Epic	{"value": 1.38, "stat_modifier": "intelligence"}	Global	44
feat_loc_abyss_052	loc_abyss_052	هاله قلمرو خلاء و سایه	Rare	{"value": 1.42, "stat_modifier": "black_knowledge_level"}	Global	34
feat_loc_volcanic_053	loc_volcanic_053	هاله سرزمین‌های گدازه و خاکستر	Rare	{"value": 1.49, "stat_modifier": "strength"}	Global	98
feat_loc_glacial_054	loc_glacial_054	هاله دشت‌های منجمد شمالی	Legendary	{"value": 1.47, "stat_modifier": "defense"}	Global	28
feat_loc_arcane_055	loc_arcane_055	هاله ارگ ماورایی مانا	Rare	{"value": 1.44, "stat_modifier": "intelligence"}	Global	20
feat_loc_abyss_056	loc_abyss_056	هاله قلمرو خلاء و سایه	Legendary	{"value": 1.28, "stat_modifier": "black_knowledge_level"}	Global	49
feat_loc_volcanic_057	loc_volcanic_057	هاله سرزمین‌های گدازه و خاکستر	Legendary	{"value": 1.12, "stat_modifier": "strength"}	Global	55
feat_loc_glacial_058	loc_glacial_058	هاله دشت‌های منجمد شمالی	Rare	{"value": 1.09, "stat_modifier": "defense"}	Global	30
feat_loc_arcane_059	loc_arcane_059	هاله ارگ ماورایی مانا	Legendary	{"value": 1.48, "stat_modifier": "intelligence"}	Global	100
feat_loc_abyss_060	loc_abyss_060	هاله قلمرو خلاء و سایه	Legendary	{"value": 1.4, "stat_modifier": "black_knowledge_level"}	Global	21
feat_loc_volcanic_061	loc_volcanic_061	هاله سرزمین‌های گدازه و خاکستر	Common	{"value": 1.22, "stat_modifier": "strength"}	Global	53
feat_loc_glacial_062	loc_glacial_062	هاله دشت‌های منجمد شمالی	Rare	{"value": 1.09, "stat_modifier": "defense"}	Global	46
feat_loc_arcane_063	loc_arcane_063	هاله ارگ ماورایی مانا	Rare	{"value": 1.09, "stat_modifier": "intelligence"}	Global	89
feat_loc_abyss_064	loc_abyss_064	هاله قلمرو خلاء و سایه	Epic	{"value": 1.4, "stat_modifier": "black_knowledge_level"}	Global	67
feat_loc_volcanic_065	loc_volcanic_065	هاله سرزمین‌های گدازه و خاکستر	Legendary	{"value": 1.26, "stat_modifier": "strength"}	Global	39
feat_loc_glacial_066	loc_glacial_066	هاله دشت‌های منجمد شمالی	Rare	{"value": 1.05, "stat_modifier": "defense"}	Global	29
feat_loc_arcane_067	loc_arcane_067	هاله ارگ ماورایی مانا	Epic	{"value": 1.12, "stat_modifier": "intelligence"}	Global	77
feat_loc_abyss_068	loc_abyss_068	هاله قلمرو خلاء و سایه	Rare	{"value": 1.25, "stat_modifier": "black_knowledge_level"}	Global	57
feat_loc_volcanic_069	loc_volcanic_069	هاله سرزمین‌های گدازه و خاکستر	Legendary	{"value": 1.32, "stat_modifier": "strength"}	Global	70
feat_loc_glacial_070	loc_glacial_070	هاله دشت‌های منجمد شمالی	Common	{"value": 1.34, "stat_modifier": "defense"}	Global	17
feat_loc_arcane_071	loc_arcane_071	هاله ارگ ماورایی مانا	Epic	{"value": 1.5, "stat_modifier": "intelligence"}	Global	98
feat_loc_abyss_072	loc_abyss_072	هاله قلمرو خلاء و سایه	Epic	{"value": 1.43, "stat_modifier": "black_knowledge_level"}	Global	85
feat_loc_volcanic_073	loc_volcanic_073	هاله سرزمین‌های گدازه و خاکستر	Epic	{"value": 1.34, "stat_modifier": "strength"}	Global	85
feat_loc_glacial_074	loc_glacial_074	هاله دشت‌های منجمد شمالی	Epic	{"value": 1.07, "stat_modifier": "defense"}	Global	83
feat_loc_arcane_075	loc_arcane_075	هاله ارگ ماورایی مانا	Epic	{"value": 1.23, "stat_modifier": "intelligence"}	Global	88
feat_loc_abyss_076	loc_abyss_076	هاله قلمرو خلاء و سایه	Legendary	{"value": 1.06, "stat_modifier": "black_knowledge_level"}	Global	83
feat_loc_volcanic_077	loc_volcanic_077	هاله سرزمین‌های گدازه و خاکستر	Epic	{"value": 1.06, "stat_modifier": "strength"}	Global	45
feat_loc_glacial_078	loc_glacial_078	هاله دشت‌های منجمد شمالی	Rare	{"value": 1.48, "stat_modifier": "defense"}	Global	93
feat_loc_arcane_079	loc_arcane_079	هاله ارگ ماورایی مانا	Legendary	{"value": 1.23, "stat_modifier": "intelligence"}	Global	14
feat_loc_abyss_080	loc_abyss_080	هاله قلمرو خلاء و سایه	Epic	{"value": 1.46, "stat_modifier": "black_knowledge_level"}	Global	23
feat_loc_volcanic_081	loc_volcanic_081	هاله سرزمین‌های گدازه و خاکستر	Rare	{"value": 1.34, "stat_modifier": "strength"}	Global	27
feat_loc_glacial_082	loc_glacial_082	هاله دشت‌های منجمد شمالی	Common	{"value": 1.07, "stat_modifier": "defense"}	Global	38
feat_loc_arcane_083	loc_arcane_083	هاله ارگ ماورایی مانا	Epic	{"value": 1.21, "stat_modifier": "intelligence"}	Global	90
feat_loc_abyss_084	loc_abyss_084	هاله قلمرو خلاء و سایه	Common	{"value": 1.11, "stat_modifier": "black_knowledge_level"}	Global	75
feat_loc_volcanic_085	loc_volcanic_085	هاله سرزمین‌های گدازه و خاکستر	Epic	{"value": 1.2, "stat_modifier": "strength"}	Global	87
feat_loc_glacial_086	loc_glacial_086	هاله دشت‌های منجمد شمالی	Rare	{"value": 1.08, "stat_modifier": "defense"}	Global	84
feat_loc_arcane_087	loc_arcane_087	هاله ارگ ماورایی مانا	Rare	{"value": 1.48, "stat_modifier": "intelligence"}	Global	100
feat_loc_abyss_088	loc_abyss_088	هاله قلمرو خلاء و سایه	Legendary	{"value": 1.08, "stat_modifier": "black_knowledge_level"}	Global	16
feat_loc_volcanic_089	loc_volcanic_089	هاله سرزمین‌های گدازه و خاکستر	Epic	{"value": 1.4, "stat_modifier": "strength"}	Global	58
feat_loc_glacial_090	loc_glacial_090	هاله دشت‌های منجمد شمالی	Epic	{"value": 1.2, "stat_modifier": "defense"}	Global	62
feat_loc_arcane_091	loc_arcane_091	هاله ارگ ماورایی مانا	Epic	{"value": 1.2, "stat_modifier": "intelligence"}	Global	59
feat_loc_abyss_092	loc_abyss_092	هاله قلمرو خلاء و سایه	Legendary	{"value": 1.42, "stat_modifier": "black_knowledge_level"}	Global	73
feat_loc_volcanic_093	loc_volcanic_093	هاله سرزمین‌های گدازه و خاکستر	Common	{"value": 1.14, "stat_modifier": "strength"}	Global	22
feat_loc_glacial_094	loc_glacial_094	هاله دشت‌های منجمد شمالی	Epic	{"value": 1.28, "stat_modifier": "defense"}	Global	90
feat_loc_arcane_095	loc_arcane_095	هاله ارگ ماورایی مانا	Rare	{"value": 1.47, "stat_modifier": "intelligence"}	Global	88
feat_loc_abyss_096	loc_abyss_096	هاله قلمرو خلاء و سایه	Epic	{"value": 1.41, "stat_modifier": "black_knowledge_level"}	Global	96
feat_loc_volcanic_097	loc_volcanic_097	هاله سرزمین‌های گدازه و خاکستر	Epic	{"value": 1.06, "stat_modifier": "strength"}	Global	34
feat_loc_glacial_098	loc_glacial_098	هاله دشت‌های منجمد شمالی	Epic	{"value": 1.5, "stat_modifier": "defense"}	Global	99
feat_loc_arcane_099	loc_arcane_099	هاله ارگ ماورایی مانا	Legendary	{"value": 1.18, "stat_modifier": "intelligence"}	Global	55
\.


--
-- Data for Name: login_history; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.login_history (login_history_id, player_id, session_id, login_at, logout_at, ip_address, user_agent, login_status, failure_reason) FROM stdin;
\.


--
-- Data for Name: market_listing; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.market_listing (listing_id, seller_id, item_instance_id, item_id, quantity, price_per_unit, currency_type, created_at, expires_at, is_sold, is_cancelled) FROM stdin;
\.


--
-- Data for Name: message; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.message (message_id, sender_player_id, receiver_player_id, sender_character_id, receiver_character_id, subject, body, attachment_json, status, sent_at, read_at) FROM stdin;
\.


--
-- Data for Name: notification; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.notification (notification_id, player_id, character_id, notification_type, title, body, payload_json, is_read, read_at, created_at, expires_at) FROM stdin;
\.


--
-- Data for Name: npc; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.npc (npc_id, name, title, npc_type, description, base_location_id, is_killable, dialogue_json, extra_properties) FROM stdin;
\.


--
-- Data for Name: npc_interaction_rule; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.npc_interaction_rule (rule_id, npc_id, required_quest_id, required_level, trigger_event, response_text, reward_json) FROM stdin;
\.


--
-- Data for Name: npc_merchant_stock; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.npc_merchant_stock (npc_id, item_id, price, currency_type, stock_quantity, refresh_time) FROM stdin;
\.


--
-- Data for Name: npc_stats; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.npc_stats (npc_id, defense, strength, speed, mana, energy, level, exp, gold, hp, hunting_points, black_knowledge_level, intelligence, luck, base_hp, base_mana, base_energy) FROM stdin;
npc_abyss_000	331	441	276	2208	100	46	46000	2375	6624	10	6	662	1	\N	\N	\N
npc_glacial_002	216	288	180	1440	100	30	30000	9973	4320	34	0	432	15	\N	\N	\N
npc_abyss_004	108	144	90	720	100	15	15000	4884	2160	80	4	216	6	\N	\N	\N
npc_glacial_006	244	326	204	1632	100	34	34000	6350	4896	2	0	489	10	\N	\N	\N
npc_abyss_008	136	182	114	912	100	19	19000	9237	2736	13	1	273	10	\N	\N	\N
npc_volcanic_009	288	384	240	1920	100	40	40000	1583	5760	0	0	576	10	\N	\N	\N
npc_glacial_010	360	480	300	2400	100	50	50000	4735	7200	10	0	720	2	\N	\N	\N
npc_arcane_011	223	297	186	1488	100	31	31000	1362	4464	0	0	446	8	\N	\N	\N
npc_abyss_012	266	355	222	1776	100	37	37000	4093	5328	3	3	532	13	\N	\N	\N
npc_volcanic_013	165	220	138	1104	100	23	23000	2656	3312	0	0	331	7	\N	\N	\N
npc_glacial_014	568	758	474	3792	100	79	79000	1204	11376	87	0	1137	15	\N	\N	\N
npc_arcane_015	396	528	330	2640	100	55	55000	2228	7920	0	0	792	6	\N	\N	\N
npc_abyss_016	439	585	366	2928	100	61	61000	5051	8784	29	2	878	13	\N	\N	\N
npc_volcanic_017	532	710	444	3552	100	74	74000	5508	10656	0	0	1065	10	\N	\N	\N
npc_glacial_018	403	537	336	2688	100	56	56000	9957	8064	89	0	806	13	\N	\N	\N
npc_arcane_019	388	518	324	2592	100	54	54000	2692	7776	0	0	777	3	\N	\N	\N
npc_volcanic_021	403	537	336	2688	100	56	56000	6354	8064	0	0	806	3	\N	\N	\N
npc_glacial_022	194	259	162	1296	100	27	27000	6244	3888	16	0	388	4	\N	\N	\N
npc_arcane_023	410	547	342	2736	100	57	57000	655	8208	0	0	820	15	\N	\N	\N
npc_abyss_024	280	374	234	1872	100	39	39000	4087	5616	93	10	561	1	\N	\N	\N
npc_glacial_026	424	566	354	2832	100	59	59000	6290	8496	60	0	849	10	\N	\N	\N
npc_arcane_027	468	624	390	3120	100	65	65000	2986	9360	0	0	936	12	\N	\N	\N
npc_abyss_028	547	729	456	3648	100	76	76000	837	10944	8	9	1094	12	\N	\N	\N
npc_glacial_030	172	230	144	1152	100	24	24000	834	3456	16	0	345	12	\N	\N	\N
npc_arcane_031	554	739	462	3696	100	77	77000	1310	11088	0	0	1108	7	\N	\N	\N
npc_abyss_032	115	153	96	768	100	16	16000	3783	2304	65	3	230	3	\N	\N	\N
npc_glacial_034	439	585	366	2928	100	61	61000	1564	8784	43	0	878	14	\N	\N	\N
npc_glacial_038	158	211	132	1056	100	22	22000	9979	3168	8	0	316	15	\N	\N	\N
npc_arcane_039	518	691	432	3456	100	72	72000	2875	10368	0	0	1036	5	\N	\N	\N
npc_abyss_040	266	355	222	1776	100	37	37000	9003	5328	17	4	532	7	\N	\N	\N
npc_glacial_042	396	528	330	2640	100	55	55000	6423	7920	88	0	792	4	\N	\N	\N
npc_arcane_043	309	412	258	2064	100	43	43000	9872	6192	0	0	619	3	\N	\N	\N
npc_abyss_044	165	220	138	1104	100	23	23000	1061	3312	91	9	331	2	\N	\N	\N
npc_glacial_046	273	364	228	1824	100	38	38000	1493	5472	80	0	547	15	\N	\N	\N
npc_arcane_047	568	758	474	3792	100	79	79000	5015	11376	0	0	1137	7	\N	\N	\N
npc_abyss_048	230	307	192	1536	100	32	32000	9970	4608	49	9	460	9	\N	\N	\N
npc_volcanic_049	504	672	420	3360	100	70	70000	8567	10080	0	0	1008	4	\N	\N	\N
npc_arcane_051	345	460	288	2304	100	48	48000	4156	6912	0	0	691	15	\N	\N	\N
npc_abyss_052	453	604	378	3024	100	63	63000	6930	9072	62	1	907	8	\N	\N	\N
npc_glacial_054	381	508	318	2544	100	53	53000	4736	7632	75	0	763	9	\N	\N	\N
npc_arcane_055	129	172	108	864	100	18	18000	3861	2592	0	0	259	11	\N	\N	\N
npc_abyss_056	108	144	90	720	100	15	15000	7708	2160	49	3	216	9	\N	\N	\N
npc_glacial_058	194	259	162	1296	100	27	27000	737	3888	63	0	388	1	\N	\N	\N
npc_arcane_059	230	307	192	1536	100	32	32000	4362	4608	0	0	460	8	\N	\N	\N
npc_abyss_060	338	451	282	2256	100	47	47000	1749	6768	46	4	676	12	\N	\N	\N
npc_glacial_062	576	768	480	3840	100	80	80000	8045	11520	24	0	1152	1	\N	\N	\N
npc_arcane_063	338	451	282	2256	100	47	47000	6226	6768	0	0	676	1	\N	\N	\N
npc_abyss_064	115	153	96	768	100	16	16000	9644	2304	2	3	230	7	\N	\N	\N
npc_glacial_066	381	508	318	2544	100	53	53000	1312	7632	66	0	763	4	\N	\N	\N
npc_arcane_067	237	316	198	1584	100	33	33000	2023	4752	0	0	475	12	\N	\N	\N
npc_abyss_068	410	547	342	2736	100	57	57000	8600	8208	20	8	820	8	\N	\N	\N
npc_volcanic_069	352	470	294	2352	100	49	49000	8290	7056	0	0	705	4	\N	\N	\N
npc_glacial_070	180	240	150	1200	100	25	25000	5923	3600	19	0	360	8	\N	\N	\N
npc_arcane_071	576	768	480	3840	100	80	80000	8528	11520	0	0	1152	4	\N	\N	\N
npc_abyss_072	460	614	384	3072	100	64	64000	3870	9216	59	6	921	9	\N	\N	\N
npc_glacial_074	144	192	120	960	100	20	20000	2823	2880	40	0	288	13	\N	\N	\N
npc_arcane_075	410	547	342	2736	100	57	57000	2568	8208	0	0	820	7	\N	\N	\N
npc_abyss_076	72	96	60	480	100	10	10000	3682	1440	77	9	144	10	\N	\N	\N
npc_volcanic_077	259	345	216	1728	100	36	36000	3737	5184	0	0	518	15	\N	\N	\N
npc_glacial_078	158	211	132	1056	100	22	22000	1415	3168	72	0	316	6	\N	\N	\N
npc_abyss_080	561	748	468	3744	100	78	78000	8372	11232	54	5	1123	15	\N	\N	\N
npc_volcanic_029	532	710	444	3495	99	74	74000	8680	6147	0	0	1065	13	\N	\N	\N
npc_arcane_007	374	499	312	2380	94	52	52000	4222	0	0	0	748	6	\N	\N	\N
npc_volcanic_065	187	249	156	1185	93	26	26000	513	0	0	0	374	11	\N	\N	\N
npc_arcane_079	79	105	66	513	97	11	11000	9654	0	0	0	158	11	\N	\N	\N
npc_glacial_050	252	336	210	1577	93	35	35000	2959	0	0	0	504	10	\N	\N	\N
npc_volcanic_001	618	518	324	2433	95	54	54000	7740	0	0	0	777	4	\N	\N	\N
npc_arcane_035	72	96	60	472	98	10	10000	9541	503	0	0	144	10	\N	\N	\N
npc_volcanic_081	537	268	168	1226	90	28	28000	6546	0	0	0	403	9	\N	\N	\N
npc_volcanic_057	144	192	120	914	95	20	20000	4034	0	0	0	288	11	\N	\N	\N
npc_arcane_003	324	432	270	2038	94	45	45000	1881	0	0	0	648	15	\N	\N	\N
npc_abyss_020	122	163	102	792	97	17	17000	3747	0	72	1	244	3	\N	\N	\N
npc_volcanic_053	489	652	408	3160	98	68	68000	1333	4735	0	0	979	10	\N	\N	\N
npc_volcanic_033	172	230	144	1054	90	24	24000	6374	0	0	0	345	13	\N	\N	\N
npc_volcanic_037	295	393	246	1785	87	41	41000	1294	0	0	0	590	13	\N	\N	\N
npc_volcanic_061	616	672	420	3271	98	70	70000	5140	8297	0	0	1008	5	\N	\N	\N
npc_volcanic_045	180	240	150	1115	90	25	25000	1950	0	0	0	360	14	\N	\N	\N
npc_volcanic_005	324	432	270	2120	97	45	45000	9812	5144	0	0	648	15	\N	\N	\N
npc_volcanic_041	676	672	420	3156	95	70	70000	1080	0	0	0	1008	5	\N	\N	\N
npc_glacial_082	489	652	408	3264	100	68	68000	5556	9792	49	0	979	1	\N	\N	\N
npc_arcane_083	410	547	342	2736	100	57	57000	3125	8208	0	0	820	8	\N	\N	\N
npc_abyss_084	496	662	414	3312	100	69	69000	8409	9936	49	0	993	7	\N	\N	\N
npc_abyss_088	331	441	276	2208	100	46	46000	6864	6624	96	3	662	10	\N	\N	\N
npc_volcanic_089	288	384	240	1920	100	40	40000	9956	5760	0	0	576	1	\N	\N	\N
npc_glacial_090	540	720	450	3600	100	75	75000	7970	10800	1	0	1080	1	\N	\N	\N
npc_arcane_091	93	124	78	624	100	13	13000	825	1872	0	0	187	2	\N	\N	\N
npc_volcanic_093	266	355	222	1776	100	37	37000	6569	5328	0	0	532	6	\N	\N	\N
npc_glacial_094	259	345	216	1728	100	36	36000	8268	5184	57	0	518	9	\N	\N	\N
npc_arcane_095	230	307	192	1536	100	32	32000	7701	4608	0	0	460	2	\N	\N	\N
npc_abyss_096	230	307	192	1536	100	32	32000	5078	4608	5	0	460	6	\N	\N	\N
npc_volcanic_097	295	393	246	1968	100	41	41000	8794	5904	0	0	590	13	\N	\N	\N
npc_glacial_098	216	288	180	1440	100	30	30000	5438	4320	36	0	432	4	\N	\N	\N
npc_arcane_099	230	307	192	1536	100	32	32000	8619	4608	0	0	460	9	\N	\N	\N
npc_abyss_100	374	499	312	2496	100	52	52000	4643	7488	9	6	748	5	\N	\N	\N
npc_glacial_102	288	384	240	1920	100	40	40000	1649	5760	100	0	576	10	\N	\N	\N
npc_abyss_104	187	249	156	1248	100	26	26000	1769	3744	52	1	374	10	\N	\N	\N
npc_volcanic_105	259	345	216	1728	100	36	36000	7186	5184	0	0	518	2	\N	\N	\N
npc_glacial_106	237	316	198	1584	100	33	33000	1711	4752	18	0	475	11	\N	\N	\N
npc_arcane_107	136	182	114	912	100	19	19000	6322	2736	0	0	273	4	\N	\N	\N
npc_abyss_108	410	547	342	2736	100	57	57000	4421	8208	63	2	820	12	\N	\N	\N
npc_glacial_110	576	768	480	3840	100	80	80000	8174	11520	40	0	1152	12	\N	\N	\N
npc_arcane_111	360	480	300	2400	100	50	50000	9586	7200	0	0	720	15	\N	\N	\N
npc_abyss_112	259	345	216	1728	100	36	36000	5446	5184	59	0	518	11	\N	\N	\N
npc_glacial_114	194	259	162	1296	100	27	27000	6229	3888	47	0	388	9	\N	\N	\N
npc_arcane_115	417	556	348	2784	100	58	58000	4912	8352	0	0	835	3	\N	\N	\N
npc_abyss_116	374	499	312	2496	100	52	52000	2495	7488	55	5	748	9	\N	\N	\N
npc_glacial_118	381	508	318	2544	100	53	53000	3390	7632	6	0	763	2	\N	\N	\N
npc_abyss_120	561	748	468	3744	100	78	78000	4238	11232	30	2	1123	4	\N	\N	\N
npc_glacial_122	129	172	108	864	100	18	18000	725	2592	14	0	259	11	\N	\N	\N
npc_arcane_123	489	652	408	3264	100	68	68000	6090	9792	0	0	979	6	\N	\N	\N
npc_abyss_124	475	633	396	3168	100	66	66000	5109	9504	32	6	950	1	\N	\N	\N
npc_arcane_127	417	556	348	2784	100	58	58000	1197	8352	0	0	835	3	\N	\N	\N
npc_glacial_130	439	585	366	2928	100	61	61000	6910	8784	100	0	878	6	\N	\N	\N
npc_arcane_131	518	691	432	3456	100	72	72000	928	10368	0	0	1036	11	\N	\N	\N
npc_abyss_132	554	739	462	3696	100	77	77000	3217	11088	41	4	1108	6	\N	\N	\N
npc_volcanic_133	360	480	300	2400	100	50	50000	4803	7200	0	0	720	5	\N	\N	\N
npc_glacial_134	309	412	258	2064	100	43	43000	725	6192	10	0	619	5	\N	\N	\N
npc_arcane_135	352	470	294	2352	100	49	49000	7057	7056	0	0	705	4	\N	\N	\N
npc_abyss_136	496	662	414	3312	100	69	69000	767	9936	14	7	993	9	\N	\N	\N
npc_glacial_138	180	240	150	1200	100	25	25000	2853	3600	84	0	360	8	\N	\N	\N
npc_arcane_139	302	403	252	2016	100	42	42000	6416	6048	0	0	604	7	\N	\N	\N
npc_abyss_140	201	268	168	1344	100	28	28000	9727	4032	13	10	403	15	\N	\N	\N
npc_volcanic_141	288	384	240	1920	100	40	40000	8523	5760	0	0	576	15	\N	\N	\N
npc_glacial_142	324	432	270	2160	100	45	45000	5376	6480	89	0	648	3	\N	\N	\N
npc_arcane_143	230	307	192	1536	100	32	32000	5884	4608	0	0	460	10	\N	\N	\N
npc_abyss_144	338	451	282	2256	100	47	47000	8075	6768	1	1	676	11	\N	\N	\N
npc_glacial_146	280	374	234	1872	100	39	39000	3799	5616	75	0	561	3	\N	\N	\N
npc_arcane_147	338	451	282	2256	100	47	47000	5039	6768	0	0	676	7	\N	\N	\N
npc_abyss_148	180	240	150	1200	100	25	25000	7215	3600	84	3	360	10	\N	\N	\N
npc_volcanic_149	266	355	222	1776	100	37	37000	6001	5328	0	0	532	3	\N	\N	\N
npc_glacial_150	489	652	408	3264	100	68	68000	4089	9792	23	0	979	5	\N	\N	\N
npc_arcane_151	554	739	462	3696	100	77	77000	9972	11088	0	0	1108	3	\N	\N	\N
npc_abyss_152	568	758	474	3792	100	79	79000	2143	11376	3	3	1137	9	\N	\N	\N
npc_glacial_154	504	672	420	3360	100	70	70000	7376	10080	94	0	1008	7	\N	\N	\N
npc_arcane_155	273	364	228	1824	100	38	38000	5693	5472	0	0	547	5	\N	\N	\N
npc_abyss_156	468	624	390	3120	100	65	65000	6457	9360	61	0	936	14	\N	\N	\N
npc_glacial_158	324	432	270	2160	100	45	45000	5924	6480	30	0	648	10	\N	\N	\N
npc_abyss_160	561	748	468	3744	100	78	78000	2590	11232	5	8	1123	1	\N	\N	\N
npc_glacial_162	244	326	204	1632	100	34	34000	8391	4896	79	0	489	1	\N	\N	\N
npc_volcanic_137	496	662	414	2930	89	69	69000	3772	0	0	0	993	1	\N	\N	\N
npc_volcanic_129	223	297	186	1038	86	31	31000	7775	0	0	0	446	14	\N	\N	\N
npc_arcane_103	79	105	66	506	95	11	11000	5738	0	0	0	158	15	\N	\N	\N
npc_glacial_086	258	192	120	936	97	20	20000	4742	0	95	0	288	12	\N	\N	\N
npc_arcane_159	136	182	114	861	94	19	19000	1905	0	0	0	273	4	\N	\N	\N
npc_arcane_087	86	115	72	560	97	12	12000	2388	0	0	0	172	4	\N	\N	\N
npc_volcanic_153	180	240	150	1165	97	25	25000	5460	0	0	0	360	5	\N	\N	\N
npc_arcane_119	72	96	60	466	97	10	10000	6786	0	0	0	144	2	\N	\N	\N
npc_abyss_092	237	316	198	1475	92	33	33000	1705	0	72	3	475	2	\N	\N	\N
npc_glacial_126	464	432	270	2038	95	45	45000	7498	2849	67	0	648	10	\N	\N	\N
npc_volcanic_117	165	220	138	879	93	23	23000	3769	0	0	0	331	5	\N	\N	\N
npc_volcanic_145	460	614	384	2797	90	64	64000	5385	0	0	0	921	5	\N	\N	\N
npc_volcanic_121	702	384	240	1792	95	40	40000	9767	0	0	0	576	10	\N	\N	\N
npc_volcanic_157	136	182	114	897	97	19	19000	4164	0	0	0	273	4	\N	\N	\N
npc_abyss_128	331	441	276	2148	96	46	46000	1425	6624	79	7	662	10	\N	\N	\N
npc_volcanic_085	468	624	390	3087	99	65	65000	1005	9355	0	0	936	4	\N	\N	\N
npc_volcanic_109	216	288	180	1309	85	30	30000	1794	0	0	0	432	7	\N	\N	\N
npc_volcanic_161	273	364	228	544	76	38	38000	2343	0	0	0	547	3	\N	\N	\N
npc_volcanic_101	630	691	432	787	72	72	72000	8756	3092	0	0	1036	8	\N	\N	\N
npc_arcane_163	547	729	456	3648	100	76	76000	1500	10944	0	0	1094	1	\N	\N	\N
npc_abyss_164	194	259	162	1296	100	27	27000	5600	3888	12	8	388	3	\N	\N	\N
npc_glacial_166	475	633	396	3168	100	66	66000	8600	9504	98	0	950	3	\N	\N	\N
npc_arcane_167	396	528	330	2640	100	55	55000	1384	7920	0	0	792	9	\N	\N	\N
npc_abyss_168	424	566	354	2832	100	59	59000	6849	8496	22	4	849	12	\N	\N	\N
npc_glacial_170	72	96	60	480	100	10	10000	633	1440	76	0	144	15	\N	\N	\N
npc_arcane_171	496	662	414	3312	100	69	69000	2833	9936	0	0	993	6	\N	\N	\N
npc_abyss_172	136	182	114	912	100	19	19000	1045	2736	51	7	273	3	\N	\N	\N
npc_glacial_174	165	220	138	1104	100	23	23000	1996	3312	58	0	331	9	\N	\N	\N
npc_arcane_175	180	240	150	1200	100	25	25000	4907	3600	0	0	360	11	\N	\N	\N
npc_abyss_176	266	355	222	1776	100	37	37000	9847	5328	99	10	532	7	\N	\N	\N
npc_glacial_178	324	432	270	2160	100	45	45000	8443	6480	77	0	648	5	\N	\N	\N
npc_arcane_179	518	691	432	3456	100	72	72000	5697	10368	0	0	1036	10	\N	\N	\N
npc_abyss_180	187	249	156	1248	100	26	26000	5650	3744	64	8	374	9	\N	\N	\N
npc_volcanic_181	266	355	222	1776	100	37	37000	6736	5328	0	0	532	10	\N	\N	\N
npc_glacial_182	208	278	174	1392	100	29	29000	7794	4176	73	0	417	14	\N	\N	\N
npc_arcane_183	295	393	246	1968	100	41	41000	5230	5904	0	0	590	3	\N	\N	\N
npc_abyss_184	525	700	438	3504	100	73	73000	7442	10512	78	3	1051	10	\N	\N	\N
npc_glacial_186	72	96	60	480	100	10	10000	6057	1440	47	0	144	10	\N	\N	\N
npc_arcane_187	525	700	438	3504	100	73	73000	5436	10512	0	0	1051	14	\N	\N	\N
npc_abyss_188	165	220	138	1104	100	23	23000	6632	3312	38	4	331	9	\N	\N	\N
npc_volcanic_189	554	739	462	3696	100	77	77000	589	11088	0	0	1108	13	\N	\N	\N
npc_glacial_190	460	614	384	3072	100	64	64000	6974	9216	19	0	921	14	\N	\N	\N
npc_arcane_191	172	230	144	1152	100	24	24000	9426	3456	0	0	345	14	\N	\N	\N
npc_abyss_192	475	633	396	3168	100	66	66000	1811	9504	39	7	950	1	\N	\N	\N
npc_glacial_194	324	432	270	2160	100	45	45000	7839	6480	73	0	648	9	\N	\N	\N
npc_arcane_195	540	720	450	3600	100	75	75000	8064	10800	0	0	1080	14	\N	\N	\N
npc_abyss_196	453	604	378	3024	100	63	63000	1318	9072	22	3	907	1	\N	\N	\N
npc_glacial_198	93	124	78	624	100	13	13000	667	1872	80	0	187	15	\N	\N	\N
npc_arcane_199	525	700	438	3504	100	73	73000	9871	10512	0	0	1051	8	\N	\N	\N
npc_abyss_036	496	662	414	3312	100	69	69000	5480	9936	75	1	993	60	\N	\N	\N
npc_volcanic_165	165	220	138	1072	97	23	23000	4180	0	0	0	331	12	\N	\N	\N
npc_volcanic_197	115	153	96	742	95	16	16000	9812	0	0	0	230	4	\N	\N	\N
npc_volcanic_113	86	115	72	550	95	12	12000	3211	0	0	0	172	6	\N	\N	\N
npc_volcanic_185	316	422	264	2004	95	44	44000	1634	0	0	0	633	12	\N	\N	\N
npc_volcanic_173	187	249	156	1171	91	26	26000	9298	0	0	0	374	10	\N	\N	\N
npc_volcanic_193	280	374	234	1787	94	39	39000	4068	0	0	0	561	8	\N	\N	\N
npc_volcanic_169	345	460	288	2223	96	48	48000	5482	0	0	0	691	15	\N	\N	\N
npc_volcanic_073	216	288	180	1305	87	30	30000	9436	0	0	0	432	5	\N	\N	\N
npc_volcanic_125	208	278	174	1370	98	29	29000	1022	2956	0	0	417	11	\N	\N	\N
npc_volcanic_025	532	710	444	3458	97	74	74000	8698	7134	0	0	1065	12	\N	\N	\N
npc_volcanic_177	295	393	246	1887	95	41	41000	7132	0	0	0	590	8	\N	\N	\N
\.


--
-- Data for Name: party; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.party (party_id, name, leader_character_id, party_type, description, created_at, updated_at, is_active) FROM stdin;
\.


--
-- Data for Name: party_member; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.party_member (party_id, character_id, member_role, joined_at, left_at, is_active) FROM stdin;
\.


--
-- Data for Name: player; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.player (player_id, telegram_id, username, created_at, last_active, role, is_banned) FROM stdin;
26b2f592-8ded-430b-a340-ebb59b52d709	7606015504	rough_engineer	2026-06-28 11:55:26.763582+00	\N	user	f
\.


--
-- Data for Name: player_mail; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.player_mail (mail_id, receiver_id, sender_name, subject, body, attachment_json, is_read, is_claimed, sent_at, expires_at) FROM stdin;
\.


--
-- Data for Name: player_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.player_session (session_id, player_id, telegram_chat_id, ip_address, user_agent, login_at, last_seen_at, logout_at, is_active, refresh_token_hash) FROM stdin;
\.


--
-- Data for Name: player_state; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.player_state (player_id, current_location_id, current_region_id, energy, step_counter, last_event_type, seed_value, last_location_change, last_event_at) FROM stdin;
\.


--
-- Data for Name: player_wallet; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.player_wallet (wallet_id, player_id, gold_balance, gem_balance, silver_balance, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: quest; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.quest (quest_id, name, location_id, difficulty_rank, reward_json, description) FROM stdin;
qst_abyss_000	کشف راز دانش سیاه در شکاف سایه‌های سرگردان	loc_abyss_000	rank_a	{"exp": 7704, "gold": 4138, "items": ["item_abyss_000"]}	ماموریتی با عنوان کشف راز دانش سیاه در شکاف سایه‌های سرگردان. بازیکن باید برای انجام این کار به مناطق خطرناک قلمرو خلاء و سایه سفر کرده و شجاعت خود را اثبات کند.
qst_volcanic_001	خاموش کردن کوره باستانی در دره سوزان آتشفشان	loc_volcanic_001	rank_c	{"exp": 2858, "gold": 2732, "items": ["item_arcane_099"]}	ماموریتی با عنوان خاموش کردن کوره باستانی در دره سوزان آتشفشان. بازیکن باید برای انجام این کار به مناطق خطرناک سرزمین‌های گدازه و خاکستر سفر کرده و شجاعت خود را اثبات کند.
qst_glacial_002	بقا در طوفان کولاک در قلعه منجمد زمستان تاریک	loc_glacial_002	rank_b	{"exp": 9435, "gold": 628, "items": ["item_glacial_126"]}	ماموریتی با عنوان بقا در طوفان کولاک در قلعه منجمد زمستان تاریک. بازیکن باید برای انجام این کار به مناطق خطرناک دشت‌های منجمد شمالی سفر کرده و شجاعت خود را اثبات کند.
qst_arcane_003	بازیابی کتاب اسرار در تالار اسرار باستانی	loc_arcane_003	rank_c	{"exp": 1946, "gold": 4401, "items": ["item_volcanic_025"]}	ماموریتی با عنوان بازیابی کتاب اسرار در تالار اسرار باستانی. بازیکن باید برای انجام این کار به مناطق خطرناک ارگ ماورایی مانا سفر کرده و شجاعت خود را اثبات کند.
qst_abyss_004	پاکسازی شکاف در شکاف ظلمت	loc_abyss_004	rank_sss	{"exp": 3587, "gold": 270, "items": ["item_glacial_010"]}	ماموریتی با عنوان پاکسازی شکاف در شکاف ظلمت. بازیکن باید برای انجام این کار به مناطق خطرناک قلمرو خلاء و سایه سفر کرده و شجاعت خود را اثبات کند.
qst_volcanic_005	شکار هیولای مذاب در دهانه سنگ جهنمی	loc_volcanic_005	rank_a	{"exp": 7910, "gold": 764, "items": ["item_abyss_056"]}	ماموریتی با عنوان شکار هیولای مذاب در دهانه سنگ جهنمی. بازیکن باید برای انجام این کار به مناطق خطرناک سرزمین‌های گدازه و خاکستر سفر کرده و شجاعت خود را اثبات کند.
qst_glacial_006	نجات گروه اکتشاف در غار بلورین زمستان تاریک	loc_glacial_006	rank_s	{"exp": 2171, "gold": 2628, "items": ["item_arcane_019"]}	ماموریتی با عنوان نجات گروه اکتشاف در غار بلورین زمستان تاریک. بازیکن باید برای انجام این کار به مناطق خطرناک دشت‌های منجمد شمالی سفر کرده و شجاعت خود را اثبات کند.
qst_arcane_007	بازیابی کتاب اسرار در باغ معلق جادوی کهن	loc_arcane_007	rank_s	{"exp": 4138, "gold": 1305, "items": ["item_volcanic_113"]}	ماموریتی با عنوان بازیابی کتاب اسرار در باغ معلق جادوی کهن. بازیکن باید برای انجام این کار به مناطق خطرناک ارگ ماورایی مانا سفر کرده و شجاعت خود را اثبات کند.
qst_abyss_008	کشف راز دانش سیاه در سیاه‌چال ظلمت	loc_abyss_008	rank_b	{"exp": 1419, "gold": 3611, "items": ["item_volcanic_053"]}	ماموریتی با عنوان کشف راز دانش سیاه در سیاه‌چال ظلمت. بازیکن باید برای انجام این کار به مناطق خطرناک قلمرو خلاء و سایه سفر کرده و شجاعت خود را اثبات کند.
qst_volcanic_009	جمع‌آوری سنگ آتشین در دره سوزان آتش ابدی	loc_volcanic_009	rank_ss	{"exp": 9405, "gold": 125, "items": ["item_abyss_028"]}	ماموریتی با عنوان جمع‌آوری سنگ آتشین در دره سوزان آتش ابدی. بازیکن باید برای انجام این کار به مناطق خطرناک سرزمین‌های گدازه و خاکستر سفر کرده و شجاعت خود را اثبات کند.
qst_glacial_010	نجات گروه اکتشاف در گردنه بلورهای جادویی	loc_glacial_010	rank_c	{"exp": 5815, "gold": 4625, "items": ["item_volcanic_061"]}	ماموریتی با عنوان نجات گروه اکتشاف در گردنه بلورهای جادویی. بازیکن باید برای انجام این کار به مناطق خطرناک دشت‌های منجمد شمالی سفر کرده و شجاعت خود را اثبات کند.
qst_arcane_011	فعال‌سازی رون‌های باستانی در باغ معلق انرژی‌های کیهانی	loc_arcane_011	rank_ss	{"exp": 5372, "gold": 2155, "items": ["item_abyss_064"]}	ماموریتی با عنوان فعال‌سازی رون‌های باستانی در باغ معلق انرژی‌های کیهانی. بازیکن باید برای انجام این کار به مناطق خطرناک ارگ ماورایی مانا سفر کرده و شجاعت خود را اثبات کند.
qst_abyss_012	کشف راز دانش سیاه در گودال مرگ ابدی	loc_abyss_012	rank_s	{"exp": 6012, "gold": 3676, "items": ["item_arcane_135"]}	ماموریتی با عنوان کشف راز دانش سیاه در گودال مرگ ابدی. بازیکن باید برای انجام این کار به مناطق خطرناک قلمرو خلاء و سایه سفر کرده و شجاعت خود را اثبات کند.
qst_volcanic_013	جمع‌آوری سنگ آتشین در دهانه سنگ جهنمی	loc_volcanic_013	rank_e	{"exp": 6729, "gold": 4461, "items": ["item_abyss_096"]}	ماموریتی با عنوان جمع‌آوری سنگ آتشین در دهانه سنگ جهنمی. بازیکن باید برای انجام این کار به مناطق خطرناک سرزمین‌های گدازه و خاکستر سفر کرده و شجاعت خود را اثبات کند.
qst_glacial_014	نجات گروه اکتشاف در غار بلورین سرمای استخوان‌سوز	loc_glacial_014	rank_ss	{"exp": 4085, "gold": 2158, "items": ["item_glacial_002"]}	ماموریتی با عنوان نجات گروه اکتشاف در غار بلورین سرمای استخوان‌سوز. بازیکن باید برای انجام این کار به مناطق خطرناک دشت‌های منجمد شمالی سفر کرده و شجاعت خود را اثبات کند.
qst_arcane_015	فعال‌سازی رون‌های باستانی در مارپیچ اسرار باستانی	loc_arcane_015	rank_b	{"exp": 9560, "gold": 4668, "items": ["item_glacial_078"]}	ماموریتی با عنوان فعال‌سازی رون‌های باستانی در مارپیچ اسرار باستانی. بازیکن باید برای انجام این کار به مناطق خطرناک ارگ ماورایی مانا سفر کرده و شجاعت خود را اثبات کند.
qst_abyss_016	نابود کردن هاله فساد در سیاه‌چال ظلمت	loc_abyss_016	rank_a	{"exp": 3337, "gold": 3791, "items": ["item_volcanic_005"]}	ماموریتی با عنوان نابود کردن هاله فساد در سیاه‌چال ظلمت. بازیکن باید برای انجام این کار به مناطق خطرناک قلمرو خلاء و سایه سفر کرده و شجاعت خود را اثبات کند.
qst_volcanic_017	جمع‌آوری سنگ آتشین در قله آتش ابدی	loc_volcanic_017	rank_b	{"exp": 7606, "gold": 4899, "items": ["item_glacial_082"]}	ماموریتی با عنوان جمع‌آوری سنگ آتشین در قله آتش ابدی. بازیکن باید برای انجام این کار به مناطق خطرناک سرزمین‌های گدازه و خاکستر سفر کرده و شجاعت خود را اثبات کند.
qst_glacial_018	بقا در طوفان کولاک در پناهگاه یخبندان شمالی	loc_glacial_018	rank_sss	{"exp": 7193, "gold": 1336, "items": ["item_abyss_140"]}	ماموریتی با عنوان بقا در طوفان کولاک در پناهگاه یخبندان شمالی. بازیکن باید برای انجام این کار به مناطق خطرناک دشت‌های منجمد شمالی سفر کرده و شجاعت خود را اثبات کند.
qst_arcane_019	فعال‌سازی رون‌های باستانی در کتابخانه اسرار باستانی	loc_arcane_019	rank_ss	{"exp": 2327, "gold": 3099, "items": ["item_arcane_095"]}	ماموریتی با عنوان فعال‌سازی رون‌های باستانی در کتابخانه اسرار باستانی. بازیکن باید برای انجام این کار به مناطق خطرناک ارگ ماورایی مانا سفر کرده و شجاعت خود را اثبات کند.
qst_abyss_020	پاکسازی شکاف در معبد تاریک خلاء	loc_abyss_020	rank_b	{"exp": 7103, "gold": 4017, "items": ["item_arcane_043"]}	ماموریتی با عنوان پاکسازی شکاف در معبد تاریک خلاء. بازیکن باید برای انجام این کار به مناطق خطرناک قلمرو خلاء و سایه سفر کرده و شجاعت خود را اثبات کند.
qst_volcanic_021	شکار هیولای مذاب در دهانه آتش ابدی	loc_volcanic_021	rank_c	{"exp": 7182, "gold": 3832, "items": ["item_abyss_116"]}	ماموریتی با عنوان شکار هیولای مذاب در دهانه آتش ابدی. بازیکن باید برای انجام این کار به مناطق خطرناک سرزمین‌های گدازه و خاکستر سفر کرده و شجاعت خود را اثبات کند.
qst_glacial_022	کشف بلور باستانی یخ در پناهگاه کولاک ابدی	loc_glacial_022	rank_ss	{"exp": 2381, "gold": 3104, "items": ["item_volcanic_029"]}	ماموریتی با عنوان کشف بلور باستانی یخ در پناهگاه کولاک ابدی. بازیکن باید برای انجام این کار به مناطق خطرناک دشت‌های منجمد شمالی سفر کرده و شجاعت خود را اثبات کند.
qst_arcane_023	بازیابی کتاب اسرار در برج جادوی کهن	loc_arcane_023	rank_e	{"exp": 7877, "gold": 3679, "items": ["item_abyss_076"]}	ماموریتی با عنوان بازیابی کتاب اسرار در برج جادوی کهن. بازیکن باید برای انجام این کار به مناطق خطرناک ارگ ماورایی مانا سفر کرده و شجاعت خود را اثبات کند.
qst_abyss_024	پاکسازی شکاف در گودال خلاء	loc_abyss_024	rank_s	{"exp": 8772, "gold": 4266, "items": ["item_arcane_039"]}	ماموریتی با عنوان پاکسازی شکاف در گودال خلاء. بازیکن باید برای انجام این کار به مناطق خطرناک قلمرو خلاء و سایه سفر کرده و شجاعت خود را اثبات کند.
qst_volcanic_025	خاموش کردن کوره باستانی در دژ آهنین گدازه مذاب	loc_volcanic_025	rank_sss	{"exp": 4361, "gold": 3228, "items": ["item_volcanic_101"]}	ماموریتی با عنوان خاموش کردن کوره باستانی در دژ آهنین گدازه مذاب. بازیکن باید برای انجام این کار به مناطق خطرناک سرزمین‌های گدازه و خاکستر سفر کرده و شجاعت خود را اثبات کند.
qst_glacial_026	کشف بلور باستانی یخ در گردنه یخبندان شمالی	loc_glacial_026	rank_b	{"exp": 9209, "gold": 3067, "items": ["item_glacial_070"]}	ماموریتی با عنوان کشف بلور باستانی یخ در گردنه یخبندان شمالی. بازیکن باید برای انجام این کار به مناطق خطرناک دشت‌های منجمد شمالی سفر کرده و شجاعت خود را اثبات کند.
qst_arcane_027	فعال‌سازی رون‌های باستانی در مارپیچ ستاره‌شناسان	loc_arcane_027	rank_s	{"exp": 6463, "gold": 1760, "items": ["item_volcanic_025"]}	ماموریتی با عنوان فعال‌سازی رون‌های باستانی در مارپیچ ستاره‌شناسان. بازیکن باید برای انجام این کار به مناطق خطرناک ارگ ماورایی مانا سفر کرده و شجاعت خود را اثبات کند.
qst_abyss_028	کشف راز دانش سیاه در معبد تاریک ظلمت	loc_abyss_028	rank_sss	{"exp": 3103, "gold": 930, "items": ["item_abyss_048"]}	ماموریتی با عنوان کشف راز دانش سیاه در معبد تاریک ظلمت. بازیکن باید برای انجام این کار به مناطق خطرناک قلمرو خلاء و سایه سفر کرده و شجاعت خود را اثبات کند.
qst_volcanic_029	شکار هیولای مذاب در کوره سنگ جهنمی	loc_volcanic_029	rank_a	{"exp": 9982, "gold": 907, "items": ["item_glacial_050"]}	ماموریتی با عنوان شکار هیولای مذاب در کوره سنگ جهنمی. بازیکن باید برای انجام این کار به مناطق خطرناک سرزمین‌های گدازه و خاکستر سفر کرده و شجاعت خود را اثبات کند.
qst_glacial_030	کشف بلور باستانی یخ در گردنه سرمای استخوان‌سوز	loc_glacial_030	rank_d	{"exp": 5333, "gold": 3442, "items": ["item_abyss_040"]}	ماموریتی با عنوان کشف بلور باستانی یخ در گردنه سرمای استخوان‌سوز. بازیکن باید برای انجام این کار به مناطق خطرناک دشت‌های منجمد شمالی سفر کرده و شجاعت خود را اثبات کند.
qst_arcane_031	بازیابی کتاب اسرار در تالار انرژی‌های کیهانی	loc_arcane_031	rank_ss	{"exp": 6444, "gold": 2297, "items": ["item_arcane_107"]}	ماموریتی با عنوان بازیابی کتاب اسرار در تالار انرژی‌های کیهانی. بازیکن باید برای انجام این کار به مناطق خطرناک ارگ ماورایی مانا سفر کرده و شجاعت خود را اثبات کند.
qst_abyss_032	کشف راز دانش سیاه در گودال مرگ ابدی	loc_abyss_032	rank_a	{"exp": 422, "gold": 4872, "items": ["item_abyss_084"]}	ماموریتی با عنوان کشف راز دانش سیاه در گودال مرگ ابدی. بازیکن باید برای انجام این کار به مناطق خطرناک قلمرو خلاء و سایه سفر کرده و شجاعت خود را اثبات کند.
qst_volcanic_033	جمع‌آوری سنگ آتشین در قله سنگ جهنمی	loc_volcanic_033	rank_a	{"exp": 3482, "gold": 3667, "items": ["item_glacial_086"]}	ماموریتی با عنوان جمع‌آوری سنگ آتشین در قله سنگ جهنمی. بازیکن باید برای انجام این کار به مناطق خطرناک سرزمین‌های گدازه و خاکستر سفر کرده و شجاعت خود را اثبات کند.
qst_glacial_034	نجات گروه اکتشاف در پناهگاه زمستان تاریک	loc_glacial_034	rank_ss	{"exp": 8579, "gold": 630, "items": ["item_abyss_140"]}	ماموریتی با عنوان نجات گروه اکتشاف در پناهگاه زمستان تاریک. بازیکن باید برای انجام این کار به مناطق خطرناک دشت‌های منجمد شمالی سفر کرده و شجاعت خود را اثبات کند.
qst_arcane_035	مهار مانای سرکش در تالار انرژی‌های کیهانی	loc_arcane_035	rank_b	{"exp": 928, "gold": 1988, "items": ["item_abyss_016"]}	ماموریتی با عنوان مهار مانای سرکش در تالار انرژی‌های کیهانی. بازیکن باید برای انجام این کار به مناطق خطرناک ارگ ماورایی مانا سفر کرده و شجاعت خود را اثبات کند.
qst_abyss_036	نابود کردن هاله فساد در گودال خلاء	loc_abyss_036	rank_s	{"exp": 8300, "gold": 3605, "items": ["item_volcanic_013"]}	ماموریتی با عنوان نابود کردن هاله فساد در گودال خلاء. بازیکن باید برای انجام این کار به مناطق خطرناک قلمرو خلاء و سایه سفر کرده و شجاعت خود را اثبات کند.
qst_volcanic_037	شکار هیولای مذاب در قله گدازه مذاب	loc_volcanic_037	rank_ss	{"exp": 9355, "gold": 1363, "items": ["item_volcanic_093"]}	ماموریتی با عنوان شکار هیولای مذاب در قله گدازه مذاب. بازیکن باید برای انجام این کار به مناطق خطرناک سرزمین‌های گدازه و خاکستر سفر کرده و شجاعت خود را اثبات کند.
qst_glacial_038	بقا در طوفان کولاک در گردنه زمستان تاریک	loc_glacial_038	rank_b	{"exp": 7282, "gold": 2491, "items": ["item_arcane_111"]}	ماموریتی با عنوان بقا در طوفان کولاک در گردنه زمستان تاریک. بازیکن باید برای انجام این کار به مناطق خطرناک دشت‌های منجمد شمالی سفر کرده و شجاعت خود را اثبات کند.
qst_arcane_039	مهار مانای سرکش در تالار اسرار باستانی	loc_arcane_039	rank_sss	{"exp": 9233, "gold": 4773, "items": ["item_volcanic_053"]}	ماموریتی با عنوان مهار مانای سرکش در تالار اسرار باستانی. بازیکن باید برای انجام این کار به مناطق خطرناک ارگ ماورایی مانا سفر کرده و شجاعت خود را اثبات کند.
qst_abyss_040	نابود کردن هاله فساد در شکاف خلاء	loc_abyss_040	rank_d	{"exp": 2983, "gold": 646, "items": ["item_volcanic_085"]}	ماموریتی با عنوان نابود کردن هاله فساد در شکاف خلاء. بازیکن باید برای انجام این کار به مناطق خطرناک قلمرو خلاء و سایه سفر کرده و شجاعت خود را اثبات کند.
qst_volcanic_041	شکار هیولای مذاب در کوره سنگ جهنمی	loc_volcanic_041	rank_ss	{"exp": 5427, "gold": 2439, "items": ["item_arcane_059"]}	ماموریتی با عنوان شکار هیولای مذاب در کوره سنگ جهنمی. بازیکن باید برای انجام این کار به مناطق خطرناک سرزمین‌های گدازه و خاکستر سفر کرده و شجاعت خود را اثبات کند.
qst_glacial_042	کشف بلور باستانی یخ در پناهگاه یخبندان شمالی	loc_glacial_042	rank_sss	{"exp": 7927, "gold": 3285, "items": ["item_arcane_099"]}	ماموریتی با عنوان کشف بلور باستانی یخ در پناهگاه یخبندان شمالی. بازیکن باید برای انجام این کار به مناطق خطرناک دشت‌های منجمد شمالی سفر کرده و شجاعت خود را اثبات کند.
qst_arcane_043	بازیابی کتاب اسرار در تالار جادوی کهن	loc_arcane_043	rank_s	{"exp": 3034, "gold": 3698, "items": ["item_abyss_044"]}	ماموریتی با عنوان بازیابی کتاب اسرار در تالار جادوی کهن. بازیکن باید برای انجام این کار به مناطق خطرناک ارگ ماورایی مانا سفر کرده و شجاعت خود را اثبات کند.
qst_abyss_044	کشف راز دانش سیاه در معبد تاریک ظلمت	loc_abyss_044	rank_s	{"exp": 4168, "gold": 2906, "items": ["item_volcanic_113"]}	ماموریتی با عنوان کشف راز دانش سیاه در معبد تاریک ظلمت. بازیکن باید برای انجام این کار به مناطق خطرناک قلمرو خلاء و سایه سفر کرده و شجاعت خود را اثبات کند.
qst_volcanic_045	شکار هیولای مذاب در کوره آتش ابدی	loc_volcanic_045	rank_b	{"exp": 4458, "gold": 222, "items": ["item_abyss_088"]}	ماموریتی با عنوان شکار هیولای مذاب در کوره آتش ابدی. بازیکن باید برای انجام این کار به مناطق خطرناک سرزمین‌های گدازه و خاکستر سفر کرده و شجاعت خود را اثبات کند.
qst_glacial_046	کشف بلور باستانی یخ در دشت یخ‌زده کولاک ابدی	loc_glacial_046	rank_sss	{"exp": 7285, "gold": 895, "items": ["item_abyss_064"]}	ماموریتی با عنوان کشف بلور باستانی یخ در دشت یخ‌زده کولاک ابدی. بازیکن باید برای انجام این کار به مناطق خطرناک دشت‌های منجمد شمالی سفر کرده و شجاعت خود را اثبات کند.
qst_arcane_047	بازیابی کتاب اسرار در کتابخانه انرژی‌های کیهانی	loc_arcane_047	rank_b	{"exp": 9009, "gold": 3546, "items": ["item_glacial_042"]}	ماموریتی با عنوان بازیابی کتاب اسرار در کتابخانه انرژی‌های کیهانی. بازیکن باید برای انجام این کار به مناطق خطرناک ارگ ماورایی مانا سفر کرده و شجاعت خود را اثبات کند.
qst_abyss_048	نابود کردن هاله فساد در دره خاموش ظلمت	loc_abyss_048	rank_s	{"exp": 6388, "gold": 2637, "items": ["item_volcanic_013"]}	ماموریتی با عنوان نابود کردن هاله فساد در دره خاموش ظلمت. بازیکن باید برای انجام این کار به مناطق خطرناک قلمرو خلاء و سایه سفر کرده و شجاعت خود را اثبات کند.
qst_volcanic_049	جمع‌آوری سنگ آتشین در دژ آهنین آتشفشان	loc_volcanic_049	rank_ss	{"exp": 1111, "gold": 4652, "items": ["item_glacial_022"]}	ماموریتی با عنوان جمع‌آوری سنگ آتشین در دژ آهنین آتشفشان. بازیکن باید برای انجام این کار به مناطق خطرناک سرزمین‌های گدازه و خاکستر سفر کرده و شجاعت خود را اثبات کند.
qst_glacial_050	کشف بلور باستانی یخ در غار بلورین کولاک ابدی	loc_glacial_050	rank_e	{"exp": 8737, "gold": 1619, "items": ["item_glacial_102"]}	ماموریتی با عنوان کشف بلور باستانی یخ در غار بلورین کولاک ابدی. بازیکن باید برای انجام این کار به مناطق خطرناک دشت‌های منجمد شمالی سفر کرده و شجاعت خود را اثبات کند.
qst_arcane_051	فعال‌سازی رون‌های باستانی در تالار انرژی‌های کیهانی	loc_arcane_051	rank_s	{"exp": 7541, "gold": 2580, "items": ["item_volcanic_009"]}	ماموریتی با عنوان فعال‌سازی رون‌های باستانی در تالار انرژی‌های کیهانی. بازیکن باید برای انجام این کار به مناطق خطرناک ارگ ماورایی مانا سفر کرده و شجاعت خود را اثبات کند.
qst_abyss_052	کشف راز دانش سیاه در شکاف سایه‌های سرگردان	loc_abyss_052	rank_a	{"exp": 2648, "gold": 4683, "items": ["item_arcane_011"]}	ماموریتی با عنوان کشف راز دانش سیاه در شکاف سایه‌های سرگردان. بازیکن باید برای انجام این کار به مناطق خطرناک قلمرو خلاء و سایه سفر کرده و شجاعت خود را اثبات کند.
qst_volcanic_053	جمع‌آوری سنگ آتشین در قله آتشفشان	loc_volcanic_053	rank_e	{"exp": 6151, "gold": 3256, "items": ["item_volcanic_121"]}	ماموریتی با عنوان جمع‌آوری سنگ آتشین در قله آتشفشان. بازیکن باید برای انجام این کار به مناطق خطرناک سرزمین‌های گدازه و خاکستر سفر کرده و شجاعت خود را اثبات کند.
qst_glacial_054	بقا در طوفان کولاک در گردنه بلورهای جادویی	loc_glacial_054	rank_d	{"exp": 944, "gold": 4978, "items": ["item_arcane_143"]}	ماموریتی با عنوان بقا در طوفان کولاک در گردنه بلورهای جادویی. بازیکن باید برای انجام این کار به مناطق خطرناک دشت‌های منجمد شمالی سفر کرده و شجاعت خود را اثبات کند.
qst_arcane_055	بازیابی کتاب اسرار در کتابخانه ستاره‌شناسان	loc_arcane_055	rank_c	{"exp": 9043, "gold": 656, "items": ["item_volcanic_085"]}	ماموریتی با عنوان بازیابی کتاب اسرار در کتابخانه ستاره‌شناسان. بازیکن باید برای انجام این کار به مناطق خطرناک ارگ ماورایی مانا سفر کرده و شجاعت خود را اثبات کند.
qst_abyss_056	پاکسازی شکاف در گودال فاسد شده	loc_abyss_056	rank_sss	{"exp": 507, "gold": 4644, "items": ["item_abyss_148"]}	ماموریتی با عنوان پاکسازی شکاف در گودال فاسد شده. بازیکن باید برای انجام این کار به مناطق خطرناک قلمرو خلاء و سایه سفر کرده و شجاعت خود را اثبات کند.
qst_volcanic_057	جمع‌آوری سنگ آتشین در کوره آتش ابدی	loc_volcanic_057	rank_sss	{"exp": 4767, "gold": 1289, "items": ["item_glacial_002"]}	ماموریتی با عنوان جمع‌آوری سنگ آتشین در کوره آتش ابدی. بازیکن باید برای انجام این کار به مناطق خطرناک سرزمین‌های گدازه و خاکستر سفر کرده و شجاعت خود را اثبات کند.
qst_glacial_058	نجات گروه اکتشاف در غار بلورین کولاک ابدی	loc_glacial_058	rank_ss	{"exp": 8831, "gold": 1960, "items": ["item_abyss_144"]}	ماموریتی با عنوان نجات گروه اکتشاف در غار بلورین کولاک ابدی. بازیکن باید برای انجام این کار به مناطق خطرناک دشت‌های منجمد شمالی سفر کرده و شجاعت خود را اثبات کند.
qst_arcane_059	بازیابی کتاب اسرار در کتابخانه مانای سرکش	loc_arcane_059	rank_a	{"exp": 4359, "gold": 4284, "items": ["item_arcane_063"]}	ماموریتی با عنوان بازیابی کتاب اسرار در کتابخانه مانای سرکش. بازیکن باید برای انجام این کار به مناطق خطرناک ارگ ماورایی مانا سفر کرده و شجاعت خود را اثبات کند.
qst_abyss_060	نابود کردن هاله فساد در سیاه‌چال ظلمت	loc_abyss_060	rank_d	{"exp": 8781, "gold": 430, "items": ["item_abyss_040"]}	ماموریتی با عنوان نابود کردن هاله فساد در سیاه‌چال ظلمت. بازیکن باید برای انجام این کار به مناطق خطرناک قلمرو خلاء و سایه سفر کرده و شجاعت خود را اثبات کند.
qst_volcanic_061	شکار هیولای مذاب در کوره آتش ابدی	loc_volcanic_061	rank_b	{"exp": 7933, "gold": 146, "items": ["item_glacial_038"]}	ماموریتی با عنوان شکار هیولای مذاب در کوره آتش ابدی. بازیکن باید برای انجام این کار به مناطق خطرناک سرزمین‌های گدازه و خاکستر سفر کرده و شجاعت خود را اثبات کند.
qst_glacial_062	نجات گروه اکتشاف در قلعه منجمد بلورهای جادویی	loc_glacial_062	rank_e	{"exp": 8496, "gold": 2553, "items": ["item_abyss_108"]}	ماموریتی با عنوان نجات گروه اکتشاف در قلعه منجمد بلورهای جادویی. بازیکن باید برای انجام این کار به مناطق خطرناک دشت‌های منجمد شمالی سفر کرده و شجاعت خود را اثبات کند.
qst_arcane_063	فعال‌سازی رون‌های باستانی در برج مانای سرکش	loc_arcane_063	rank_b	{"exp": 7993, "gold": 4977, "items": ["item_glacial_026"]}	ماموریتی با عنوان فعال‌سازی رون‌های باستانی در برج مانای سرکش. بازیکن باید برای انجام این کار به مناطق خطرناک ارگ ماورایی مانا سفر کرده و شجاعت خود را اثبات کند.
qst_abyss_064	کشف راز دانش سیاه در معبد تاریک سایه‌های سرگردان	loc_abyss_064	rank_s	{"exp": 5974, "gold": 806, "items": ["item_arcane_143"]}	ماموریتی با عنوان کشف راز دانش سیاه در معبد تاریک سایه‌های سرگردان. بازیکن باید برای انجام این کار به مناطق خطرناک قلمرو خلاء و سایه سفر کرده و شجاعت خود را اثبات کند.
qst_volcanic_065	خاموش کردن کوره باستانی در دژ آهنین سنگ جهنمی	loc_volcanic_065	rank_s	{"exp": 492, "gold": 3572, "items": ["item_abyss_120"]}	ماموریتی با عنوان خاموش کردن کوره باستانی در دژ آهنین سنگ جهنمی. بازیکن باید برای انجام این کار به مناطق خطرناک سرزمین‌های گدازه و خاکستر سفر کرده و شجاعت خود را اثبات کند.
qst_glacial_066	بقا در طوفان کولاک در گردنه کولاک ابدی	loc_glacial_066	rank_a	{"exp": 8639, "gold": 509, "items": ["item_abyss_064"]}	ماموریتی با عنوان بقا در طوفان کولاک در گردنه کولاک ابدی. بازیکن باید برای انجام این کار به مناطق خطرناک دشت‌های منجمد شمالی سفر کرده و شجاعت خود را اثبات کند.
qst_arcane_067	مهار مانای سرکش در کتابخانه مانای سرکش	loc_arcane_067	rank_d	{"exp": 9551, "gold": 3415, "items": ["item_abyss_064"]}	ماموریتی با عنوان مهار مانای سرکش در کتابخانه مانای سرکش. بازیکن باید برای انجام این کار به مناطق خطرناک ارگ ماورایی مانا سفر کرده و شجاعت خود را اثبات کند.
qst_abyss_068	نابود کردن هاله فساد در گودال سایه‌های سرگردان	loc_abyss_068	rank_e	{"exp": 1594, "gold": 3743, "items": ["item_volcanic_033"]}	ماموریتی با عنوان نابود کردن هاله فساد در گودال سایه‌های سرگردان. بازیکن باید برای انجام این کار به مناطق خطرناک قلمرو خلاء و سایه سفر کرده و شجاعت خود را اثبات کند.
qst_volcanic_069	جمع‌آوری سنگ آتشین در قله خاکستر سرخ	loc_volcanic_069	rank_d	{"exp": 6477, "gold": 3092, "items": ["item_glacial_146"]}	ماموریتی با عنوان جمع‌آوری سنگ آتشین در قله خاکستر سرخ. بازیکن باید برای انجام این کار به مناطق خطرناک سرزمین‌های گدازه و خاکستر سفر کرده و شجاعت خود را اثبات کند.
qst_glacial_070	کشف بلور باستانی یخ در غار بلورین بلورهای جادویی	loc_glacial_070	rank_a	{"exp": 7148, "gold": 983, "items": ["item_volcanic_069"]}	ماموریتی با عنوان کشف بلور باستانی یخ در غار بلورین بلورهای جادویی. بازیکن باید برای انجام این کار به مناطق خطرناک دشت‌های منجمد شمالی سفر کرده و شجاعت خود را اثبات کند.
qst_arcane_071	بازیابی کتاب اسرار در مارپیچ ستاره‌شناسان	loc_arcane_071	rank_b	{"exp": 5866, "gold": 4506, "items": ["item_arcane_011"]}	ماموریتی با عنوان بازیابی کتاب اسرار در مارپیچ ستاره‌شناسان. بازیکن باید برای انجام این کار به مناطق خطرناک ارگ ماورایی مانا سفر کرده و شجاعت خود را اثبات کند.
qst_abyss_072	کشف راز دانش سیاه در گودال خلاء	loc_abyss_072	rank_sss	{"exp": 592, "gold": 1144, "items": ["item_abyss_080"]}	ماموریتی با عنوان کشف راز دانش سیاه در گودال خلاء. بازیکن باید برای انجام این کار به مناطق خطرناک قلمرو خلاء و سایه سفر کرده و شجاعت خود را اثبات کند.
qst_volcanic_073	جمع‌آوری سنگ آتشین در دره سوزان آتشفشان	loc_volcanic_073	rank_ss	{"exp": 3525, "gold": 4460, "items": ["item_glacial_050"]}	ماموریتی با عنوان جمع‌آوری سنگ آتشین در دره سوزان آتشفشان. بازیکن باید برای انجام این کار به مناطق خطرناک سرزمین‌های گدازه و خاکستر سفر کرده و شجاعت خود را اثبات کند.
qst_glacial_074	کشف بلور باستانی یخ در دشت یخ‌زده سرمای استخوان‌سوز	loc_glacial_074	rank_s	{"exp": 6373, "gold": 484, "items": ["item_volcanic_105"]}	ماموریتی با عنوان کشف بلور باستانی یخ در دشت یخ‌زده سرمای استخوان‌سوز. بازیکن باید برای انجام این کار به مناطق خطرناک دشت‌های منجمد شمالی سفر کرده و شجاعت خود را اثبات کند.
qst_arcane_075	مهار مانای سرکش در مارپیچ ستاره‌شناسان	loc_arcane_075	rank_e	{"exp": 2596, "gold": 2160, "items": ["item_glacial_146"]}	ماموریتی با عنوان مهار مانای سرکش در مارپیچ ستاره‌شناسان. بازیکن باید برای انجام این کار به مناطق خطرناک ارگ ماورایی مانا سفر کرده و شجاعت خود را اثبات کند.
qst_abyss_076	نابود کردن هاله فساد در سیاه‌چال فاسد شده	loc_abyss_076	rank_s	{"exp": 6056, "gold": 4628, "items": ["item_glacial_026"]}	ماموریتی با عنوان نابود کردن هاله فساد در سیاه‌چال فاسد شده. بازیکن باید برای انجام این کار به مناطق خطرناک قلمرو خلاء و سایه سفر کرده و شجاعت خود را اثبات کند.
qst_volcanic_077	شکار هیولای مذاب در دژ آهنین سنگ جهنمی	loc_volcanic_077	rank_d	{"exp": 3020, "gold": 606, "items": ["item_glacial_130"]}	ماموریتی با عنوان شکار هیولای مذاب در دژ آهنین سنگ جهنمی. بازیکن باید برای انجام این کار به مناطق خطرناک سرزمین‌های گدازه و خاکستر سفر کرده و شجاعت خود را اثبات کند.
qst_glacial_078	بقا در طوفان کولاک در غار بلورین سرمای استخوان‌سوز	loc_glacial_078	rank_b	{"exp": 4860, "gold": 396, "items": ["item_glacial_010"]}	ماموریتی با عنوان بقا در طوفان کولاک در غار بلورین سرمای استخوان‌سوز. بازیکن باید برای انجام این کار به مناطق خطرناک دشت‌های منجمد شمالی سفر کرده و شجاعت خود را اثبات کند.
qst_arcane_079	مهار مانای سرکش در برج مانای سرکش	loc_arcane_079	rank_s	{"exp": 5321, "gold": 2607, "items": ["item_volcanic_025"]}	ماموریتی با عنوان مهار مانای سرکش در برج مانای سرکش. بازیکن باید برای انجام این کار به مناطق خطرناک ارگ ماورایی مانا سفر کرده و شجاعت خود را اثبات کند.
qst_abyss_080	پاکسازی شکاف در سیاه‌چال خلاء	loc_abyss_080	rank_b	{"exp": 8520, "gold": 4897, "items": ["item_arcane_091"]}	ماموریتی با عنوان پاکسازی شکاف در سیاه‌چال خلاء. بازیکن باید برای انجام این کار به مناطق خطرناک قلمرو خلاء و سایه سفر کرده و شجاعت خود را اثبات کند.
qst_volcanic_081	خاموش کردن کوره باستانی در دژ آهنین سنگ جهنمی	loc_volcanic_081	rank_c	{"exp": 681, "gold": 3250, "items": ["item_abyss_124"]}	ماموریتی با عنوان خاموش کردن کوره باستانی در دژ آهنین سنگ جهنمی. بازیکن باید برای انجام این کار به مناطق خطرناک سرزمین‌های گدازه و خاکستر سفر کرده و شجاعت خود را اثبات کند.
qst_glacial_082	بقا در طوفان کولاک در قلعه منجمد کولاک ابدی	loc_glacial_082	rank_e	{"exp": 1297, "gold": 858, "items": ["item_arcane_107"]}	ماموریتی با عنوان بقا در طوفان کولاک در قلعه منجمد کولاک ابدی. بازیکن باید برای انجام این کار به مناطق خطرناک دشت‌های منجمد شمالی سفر کرده و شجاعت خود را اثبات کند.
qst_arcane_083	فعال‌سازی رون‌های باستانی در مارپیچ جادوی کهن	loc_arcane_083	rank_c	{"exp": 2743, "gold": 3842, "items": ["item_volcanic_017"]}	ماموریتی با عنوان فعال‌سازی رون‌های باستانی در مارپیچ جادوی کهن. بازیکن باید برای انجام این کار به مناطق خطرناک ارگ ماورایی مانا سفر کرده و شجاعت خود را اثبات کند.
qst_abyss_084	نابود کردن هاله فساد در معبد تاریک مرگ ابدی	loc_abyss_084	rank_c	{"exp": 6343, "gold": 3928, "items": ["item_arcane_039"]}	ماموریتی با عنوان نابود کردن هاله فساد در معبد تاریک مرگ ابدی. بازیکن باید برای انجام این کار به مناطق خطرناک قلمرو خلاء و سایه سفر کرده و شجاعت خود را اثبات کند.
qst_volcanic_085	جمع‌آوری سنگ آتشین در دره سوزان آتشفشان	loc_volcanic_085	rank_e	{"exp": 4600, "gold": 325, "items": ["item_abyss_088"]}	ماموریتی با عنوان جمع‌آوری سنگ آتشین در دره سوزان آتشفشان. بازیکن باید برای انجام این کار به مناطق خطرناک سرزمین‌های گدازه و خاکستر سفر کرده و شجاعت خود را اثبات کند.
qst_glacial_086	کشف بلور باستانی یخ در پناهگاه سرمای استخوان‌سوز	loc_glacial_086	rank_c	{"exp": 8147, "gold": 3225, "items": ["item_abyss_124"]}	ماموریتی با عنوان کشف بلور باستانی یخ در پناهگاه سرمای استخوان‌سوز. بازیکن باید برای انجام این کار به مناطق خطرناک دشت‌های منجمد شمالی سفر کرده و شجاعت خود را اثبات کند.
qst_arcane_087	مهار مانای سرکش در برج مانای سرکش	loc_arcane_087	rank_e	{"exp": 5302, "gold": 4252, "items": ["item_abyss_092"]}	ماموریتی با عنوان مهار مانای سرکش در برج مانای سرکش. بازیکن باید برای انجام این کار به مناطق خطرناک ارگ ماورایی مانا سفر کرده و شجاعت خود را اثبات کند.
qst_abyss_088	نابود کردن هاله فساد در دره خاموش مرگ ابدی	loc_abyss_088	rank_s	{"exp": 3124, "gold": 4176, "items": ["item_arcane_103"]}	ماموریتی با عنوان نابود کردن هاله فساد در دره خاموش مرگ ابدی. بازیکن باید برای انجام این کار به مناطق خطرناک قلمرو خلاء و سایه سفر کرده و شجاعت خود را اثبات کند.
qst_volcanic_089	شکار هیولای مذاب در دره سوزان گدازه مذاب	loc_volcanic_089	rank_d	{"exp": 6162, "gold": 2014, "items": ["item_glacial_002"]}	ماموریتی با عنوان شکار هیولای مذاب در دره سوزان گدازه مذاب. بازیکن باید برای انجام این کار به مناطق خطرناک سرزمین‌های گدازه و خاکستر سفر کرده و شجاعت خود را اثبات کند.
qst_glacial_090	نجات گروه اکتشاف در غار بلورین کولاک ابدی	loc_glacial_090	rank_d	{"exp": 9249, "gold": 3344, "items": ["item_volcanic_069"]}	ماموریتی با عنوان نجات گروه اکتشاف در غار بلورین کولاک ابدی. بازیکن باید برای انجام این کار به مناطق خطرناک دشت‌های منجمد شمالی سفر کرده و شجاعت خود را اثبات کند.
qst_arcane_091	فعال‌سازی رون‌های باستانی در مارپیچ اسرار باستانی	loc_arcane_091	rank_c	{"exp": 4337, "gold": 4776, "items": ["item_abyss_132"]}	ماموریتی با عنوان فعال‌سازی رون‌های باستانی در مارپیچ اسرار باستانی. بازیکن باید برای انجام این کار به مناطق خطرناک ارگ ماورایی مانا سفر کرده و شجاعت خود را اثبات کند.
qst_abyss_092	کشف راز دانش سیاه در گودال فاسد شده	loc_abyss_092	rank_e	{"exp": 5698, "gold": 146, "items": ["item_glacial_106"]}	ماموریتی با عنوان کشف راز دانش سیاه در گودال فاسد شده. بازیکن باید برای انجام این کار به مناطق خطرناک قلمرو خلاء و سایه سفر کرده و شجاعت خود را اثبات کند.
qst_volcanic_093	خاموش کردن کوره باستانی در قله آتش ابدی	loc_volcanic_093	rank_d	{"exp": 3101, "gold": 4563, "items": ["item_volcanic_057"]}	ماموریتی با عنوان خاموش کردن کوره باستانی در قله آتش ابدی. بازیکن باید برای انجام این کار به مناطق خطرناک سرزمین‌های گدازه و خاکستر سفر کرده و شجاعت خود را اثبات کند.
qst_glacial_094	بقا در طوفان کولاک در گردنه بلورهای جادویی	loc_glacial_094	rank_s	{"exp": 3431, "gold": 3650, "items": ["item_arcane_003"]}	ماموریتی با عنوان بقا در طوفان کولاک در گردنه بلورهای جادویی. بازیکن باید برای انجام این کار به مناطق خطرناک دشت‌های منجمد شمالی سفر کرده و شجاعت خود را اثبات کند.
qst_arcane_095	مهار مانای سرکش در کتابخانه جادوی کهن	loc_arcane_095	rank_ss	{"exp": 4030, "gold": 3819, "items": ["item_abyss_052"]}	ماموریتی با عنوان مهار مانای سرکش در کتابخانه جادوی کهن. بازیکن باید برای انجام این کار به مناطق خطرناک ارگ ماورایی مانا سفر کرده و شجاعت خود را اثبات کند.
qst_abyss_096	پاکسازی شکاف در گودال مرگ ابدی	loc_abyss_096	rank_a	{"exp": 1504, "gold": 266, "items": ["item_abyss_144"]}	ماموریتی با عنوان پاکسازی شکاف در گودال مرگ ابدی. بازیکن باید برای انجام این کار به مناطق خطرناک قلمرو خلاء و سایه سفر کرده و شجاعت خود را اثبات کند.
qst_volcanic_097	جمع‌آوری سنگ آتشین در دژ آهنین آتشفشان	loc_volcanic_097	rank_b	{"exp": 5852, "gold": 274, "items": ["item_volcanic_093"]}	ماموریتی با عنوان جمع‌آوری سنگ آتشین در دژ آهنین آتشفشان. بازیکن باید برای انجام این کار به مناطق خطرناک سرزمین‌های گدازه و خاکستر سفر کرده و شجاعت خود را اثبات کند.
qst_glacial_098	نجات گروه اکتشاف در غار بلورین سرمای استخوان‌سوز	loc_glacial_098	rank_sss	{"exp": 9700, "gold": 2501, "items": ["item_arcane_131"]}	ماموریتی با عنوان نجات گروه اکتشاف در غار بلورین سرمای استخوان‌سوز. بازیکن باید برای انجام این کار به مناطق خطرناک دشت‌های منجمد شمالی سفر کرده و شجاعت خود را اثبات کند.
qst_arcane_099	بازیابی کتاب اسرار در کتابخانه جادوی کهن	loc_arcane_099	rank_ss	{"exp": 7439, "gold": 171, "items": ["item_arcane_071"]}	ماموریتی با عنوان بازیابی کتاب اسرار در کتابخانه جادوی کهن. بازیکن باید برای انجام این کار به مناطق خطرناک ارگ ماورایی مانا سفر کرده و شجاعت خود را اثبات کند.
\.


--
-- Data for Name: race; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.race (race_id, name, talent_modifiers, description, spawn_weight, civilization_id, base_stats_modifier) FROM stdin;
race_human	انسان	{"strength": 2, "intelligence": 2}	نژادی با پتانسیل نامحدود و سازگار با هر دو تمدن.	50	1	{"strength": 2, "intelligence": 2}
race_drakonid	دراگونید	{"defense": 4, "strength": 6}	موجوداتی نیمه اژدها با پوست سنگی و قدرت بدنی بالا.	20	1	{"defense": 4, "strength": 6}
race_sylph	سیلف	{"mana": 3, "speed": 5}	موجودات بادپا و لطیف با کنترل بالا روی انرژی باد.	15	2	{"mana": 3, "speed": 5}
race_voidborn	زاده خلاء	{"mana": 5, "black_knowledge_level": 5}	نژادی مرموز که از انرژی‌های تاریک خلاء تغذیه می‌کنند.	10	2	{"mana": 5, "black_knowledge_level": 5}
\.


--
-- Data for Name: rank; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rank (rank_id, name, power_multiplier, description) FROM stdin;
rank_e	E	1.0	رتبه تازه‌کار - بدون قدرت ویژه
rank_d	D	1.5	رتبه ماجراجوی ساده
rank_c	C	2.2	رتبه جنگجوی با تجربه
rank_b	B	3.0	رتبه نخبه قلمرو
rank_a	A	4.5	رتبه استاد جنگی
rank_s	S	6.5	رتبه قهرمان افسانه‌ای
rank_ss	SS	9.0	رتبه نیمه‌خدا
rank_sss	SSS	15.0	رتبه ویرانگر جهان‌ها (اسطوره‌ای)
\.


--
-- Data for Name: skill; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.skill (skill_id, name, description, type, mana_cost, cooldown) FROM stdin;
skill_abyss_000	انفجار خلاء ظلمت	مهارت انفجار خلاء ظلمت که به فرد اجازه می‌دهد انرژی‌های Abyss را کنترل کند. استفاده از این مهارت نیاز به مانا و تمرکز بالا دارد.	Abyss	60	18
skill_volcanic_001	پوست سنگی سوزان آتش ابدی	مهارت پوست سنگی سوزان آتش ابدی که به فرد اجازه می‌دهد انرژی‌های Volcanic را کنترل کند. استفاده از این مهارت نیاز به مانا و تمرکز بالا دارد.	Volcanic	59	6
skill_glacial_002	لمس سرما کولاک ابدی	مهارت لمس سرما کولاک ابدی که به فرد اجازه می‌دهد انرژی‌های Glacial را کنترل کند. استفاده از این مهارت نیاز به مانا و تمرکز بالا دارد.	Glacial	86	12
skill_arcane_003	تله‌پورت کوتاه جادوی کهن	مهارت تله‌پورت کوتاه جادوی کهن که به فرد اجازه می‌دهد انرژی‌های Arcane را کنترل کند. استفاده از این مهارت نیاز به مانا و تمرکز بالا دارد.	Arcane	37	16
skill_abyss_004	قدم زدن در تاریکی خلاء	مهارت قدم زدن در تاریکی خلاء که به فرد اجازه می‌دهد انرژی‌های Abyss را کنترل کند. استفاده از این مهارت نیاز به مانا و تمرکز بالا دارد.	Abyss	14	11
skill_volcanic_005	پوست سنگی سوزان گدازه مذاب	مهارت پوست سنگی سوزان گدازه مذاب که به فرد اجازه می‌دهد انرژی‌های Volcanic را کنترل کند. استفاده از این مهارت نیاز به مانا و تمرکز بالا دارد.	Volcanic	85	12
skill_glacial_006	لمس سرما یخبندان شمالی	مهارت لمس سرما یخبندان شمالی که به فرد اجازه می‌دهد انرژی‌های Glacial را کنترل کند. استفاده از این مهارت نیاز به مانا و تمرکز بالا دارد.	Glacial	11	18
skill_arcane_007	انفجار ستاره‌ای اسرار باستانی	مهارت انفجار ستاره‌ای اسرار باستانی که به فرد اجازه می‌دهد انرژی‌های Arcane را کنترل کند. استفاده از این مهارت نیاز به مانا و تمرکز بالا دارد.	Arcane	107	11
skill_abyss_008	انفجار خلاء ظلمت	مهارت انفجار خلاء ظلمت که به فرد اجازه می‌دهد انرژی‌های Abyss را کنترل کند. استفاده از این مهارت نیاز به مانا و تمرکز بالا دارد.	Abyss	99	19
skill_volcanic_009	شلاق شعله‌ور سنگ جهنمی	مهارت شلاق شعله‌ور سنگ جهنمی که به فرد اجازه می‌دهد انرژی‌های Volcanic را کنترل کند. استفاده از این مهارت نیاز به مانا و تمرکز بالا دارد.	Volcanic	46	28
skill_glacial_010	حصار منجمد بلورهای جادویی	مهارت حصار منجمد بلورهای جادویی که به فرد اجازه می‌دهد انرژی‌های Glacial را کنترل کند. استفاده از این مهارت نیاز به مانا و تمرکز بالا دارد.	Glacial	100	19
skill_arcane_011	تله‌پورت کوتاه اسرار باستانی	مهارت تله‌پورت کوتاه اسرار باستانی که به فرد اجازه می‌دهد انرژی‌های Arcane را کنترل کند. استفاده از این مهارت نیاز به مانا و تمرکز بالا دارد.	Arcane	29	19
skill_abyss_012	قدم زدن در تاریکی فاسد شده	مهارت قدم زدن در تاریکی فاسد شده که به فرد اجازه می‌دهد انرژی‌های Abyss را کنترل کند. استفاده از این مهارت نیاز به مانا و تمرکز بالا دارد.	Abyss	71	13
skill_volcanic_013	باران گدازه خاکستر سرخ	مهارت باران گدازه خاکستر سرخ که به فرد اجازه می‌دهد انرژی‌های Volcanic را کنترل کند. استفاده از این مهارت نیاز به مانا و تمرکز بالا دارد.	Volcanic	60	23
skill_glacial_014	حصار منجمد یخبندان شمالی	مهارت حصار منجمد یخبندان شمالی که به فرد اجازه می‌دهد انرژی‌های Glacial را کنترل کند. استفاده از این مهارت نیاز به مانا و تمرکز بالا دارد.	Glacial	108	18
skill_arcane_015	تله‌پورت کوتاه اسرار باستانی	مهارت تله‌پورت کوتاه اسرار باستانی که به فرد اجازه می‌دهد انرژی‌های Arcane را کنترل کند. استفاده از این مهارت نیاز به مانا و تمرکز بالا دارد.	Arcane	15	25
skill_abyss_016	قدم زدن در تاریکی مرگ ابدی	مهارت قدم زدن در تاریکی مرگ ابدی که به فرد اجازه می‌دهد انرژی‌های Abyss را کنترل کند. استفاده از این مهارت نیاز به مانا و تمرکز بالا دارد.	Abyss	55	3
skill_volcanic_017	شلاق شعله‌ور آتش ابدی	مهارت شلاق شعله‌ور آتش ابدی که به فرد اجازه می‌دهد انرژی‌های Volcanic را کنترل کند. استفاده از این مهارت نیاز به مانا و تمرکز بالا دارد.	Volcanic	117	15
skill_glacial_018	لمس سرما زمستان تاریک	مهارت لمس سرما زمستان تاریک که به فرد اجازه می‌دهد انرژی‌های Glacial را کنترل کند. استفاده از این مهارت نیاز به مانا و تمرکز بالا دارد.	Glacial	13	14
skill_arcane_019	تله‌پورت کوتاه جادوی کهن	مهارت تله‌پورت کوتاه جادوی کهن که به فرد اجازه می‌دهد انرژی‌های Arcane را کنترل کند. استفاده از این مهارت نیاز به مانا و تمرکز بالا دارد.	Arcane	12	2
skill_abyss_020	سپر سایه‌ها خلاء	مهارت سپر سایه‌ها خلاء که به فرد اجازه می‌دهد انرژی‌های Abyss را کنترل کند. استفاده از این مهارت نیاز به مانا و تمرکز بالا دارد.	Abyss	13	12
skill_volcanic_021	شلاق شعله‌ور آتش ابدی	مهارت شلاق شعله‌ور آتش ابدی که به فرد اجازه می‌دهد انرژی‌های Volcanic را کنترل کند. استفاده از این مهارت نیاز به مانا و تمرکز بالا دارد.	Volcanic	80	18
skill_glacial_022	حصار منجمد یخبندان شمالی	مهارت حصار منجمد یخبندان شمالی که به فرد اجازه می‌دهد انرژی‌های Glacial را کنترل کند. استفاده از این مهارت نیاز به مانا و تمرکز بالا دارد.	Glacial	19	23
skill_arcane_023	سپر کیهانی ستاره‌شناسان	مهارت سپر کیهانی ستاره‌شناسان که به فرد اجازه می‌دهد انرژی‌های Arcane را کنترل کند. استفاده از این مهارت نیاز به مانا و تمرکز بالا دارد.	Arcane	38	23
skill_abyss_024	قدم زدن در تاریکی مرگ ابدی	مهارت قدم زدن در تاریکی مرگ ابدی که به فرد اجازه می‌دهد انرژی‌های Abyss را کنترل کند. استفاده از این مهارت نیاز به مانا و تمرکز بالا دارد.	Abyss	119	21
skill_volcanic_025	پوست سنگی سوزان خاکستر سرخ	مهارت پوست سنگی سوزان خاکستر سرخ که به فرد اجازه می‌دهد انرژی‌های Volcanic را کنترل کند. استفاده از این مهارت نیاز به مانا و تمرکز بالا دارد.	Volcanic	39	5
skill_glacial_026	لمس سرما یخبندان شمالی	مهارت لمس سرما یخبندان شمالی که به فرد اجازه می‌دهد انرژی‌های Glacial را کنترل کند. استفاده از این مهارت نیاز به مانا و تمرکز بالا دارد.	Glacial	33	18
skill_arcane_027	انفجار ستاره‌ای مانای سرکش	مهارت انفجار ستاره‌ای مانای سرکش که به فرد اجازه می‌دهد انرژی‌های Arcane را کنترل کند. استفاده از این مهارت نیاز به مانا و تمرکز بالا دارد.	Arcane	46	17
skill_abyss_028	قدم زدن در تاریکی ظلمت	مهارت قدم زدن در تاریکی ظلمت که به فرد اجازه می‌دهد انرژی‌های Abyss را کنترل کند. استفاده از این مهارت نیاز به مانا و تمرکز بالا دارد.	Abyss	87	14
skill_volcanic_029	شلاق شعله‌ور خاکستر سرخ	مهارت شلاق شعله‌ور خاکستر سرخ که به فرد اجازه می‌دهد انرژی‌های Volcanic را کنترل کند. استفاده از این مهارت نیاز به مانا و تمرکز بالا دارد.	Volcanic	39	10
skill_glacial_030	لمس سرما کولاک ابدی	مهارت لمس سرما کولاک ابدی که به فرد اجازه می‌دهد انرژی‌های Glacial را کنترل کند. استفاده از این مهارت نیاز به مانا و تمرکز بالا دارد.	Glacial	33	13
skill_arcane_031	انفجار ستاره‌ای اسرار باستانی	مهارت انفجار ستاره‌ای اسرار باستانی که به فرد اجازه می‌دهد انرژی‌های Arcane را کنترل کند. استفاده از این مهارت نیاز به مانا و تمرکز بالا دارد.	Arcane	26	7
skill_abyss_032	قدم زدن در تاریکی فاسد شده	مهارت قدم زدن در تاریکی فاسد شده که به فرد اجازه می‌دهد انرژی‌های Abyss را کنترل کند. استفاده از این مهارت نیاز به مانا و تمرکز بالا دارد.	Abyss	83	25
skill_volcanic_033	شلاق شعله‌ور گدازه مذاب	مهارت شلاق شعله‌ور گدازه مذاب که به فرد اجازه می‌دهد انرژی‌های Volcanic را کنترل کند. استفاده از این مهارت نیاز به مانا و تمرکز بالا دارد.	Volcanic	89	12
skill_glacial_034	طوفان کولاک بلورهای جادویی	مهارت طوفان کولاک بلورهای جادویی که به فرد اجازه می‌دهد انرژی‌های Glacial را کنترل کند. استفاده از این مهارت نیاز به مانا و تمرکز بالا دارد.	Glacial	46	29
skill_arcane_035	انفجار ستاره‌ای ستاره‌شناسان	مهارت انفجار ستاره‌ای ستاره‌شناسان که به فرد اجازه می‌دهد انرژی‌های Arcane را کنترل کند. استفاده از این مهارت نیاز به مانا و تمرکز بالا دارد.	Arcane	103	19
skill_abyss_036	انفجار خلاء مرگ ابدی	مهارت انفجار خلاء مرگ ابدی که به فرد اجازه می‌دهد انرژی‌های Abyss را کنترل کند. استفاده از این مهارت نیاز به مانا و تمرکز بالا دارد.	Abyss	95	21
skill_volcanic_037	انفجار حرارتی آتش ابدی	مهارت انفجار حرارتی آتش ابدی که به فرد اجازه می‌دهد انرژی‌های Volcanic را کنترل کند. استفاده از این مهارت نیاز به مانا و تمرکز بالا دارد.	Volcanic	34	22
skill_glacial_038	لمس سرما بلورهای جادویی	مهارت لمس سرما بلورهای جادویی که به فرد اجازه می‌دهد انرژی‌های Glacial را کنترل کند. استفاده از این مهارت نیاز به مانا و تمرکز بالا دارد.	Glacial	67	18
skill_arcane_039	انفجار ستاره‌ای مانای سرکش	مهارت انفجار ستاره‌ای مانای سرکش که به فرد اجازه می‌دهد انرژی‌های Arcane را کنترل کند. استفاده از این مهارت نیاز به مانا و تمرکز بالا دارد.	Arcane	84	2
skill_abyss_040	سپر سایه‌ها مرگ ابدی	مهارت سپر سایه‌ها مرگ ابدی که به فرد اجازه می‌دهد انرژی‌های Abyss را کنترل کند. استفاده از این مهارت نیاز به مانا و تمرکز بالا دارد.	Abyss	91	6
skill_volcanic_041	شلاق شعله‌ور سنگ جهنمی	مهارت شلاق شعله‌ور سنگ جهنمی که به فرد اجازه می‌دهد انرژی‌های Volcanic را کنترل کند. استفاده از این مهارت نیاز به مانا و تمرکز بالا دارد.	Volcanic	54	3
skill_glacial_042	طوفان کولاک یخبندان شمالی	مهارت طوفان کولاک یخبندان شمالی که به فرد اجازه می‌دهد انرژی‌های Glacial را کنترل کند. استفاده از این مهارت نیاز به مانا و تمرکز بالا دارد.	Glacial	100	20
skill_arcane_043	سپر کیهانی مانای سرکش	مهارت سپر کیهانی مانای سرکش که به فرد اجازه می‌دهد انرژی‌های Arcane را کنترل کند. استفاده از این مهارت نیاز به مانا و تمرکز بالا دارد.	Arcane	39	28
skill_abyss_044	سپر سایه‌ها مرگ ابدی	مهارت سپر سایه‌ها مرگ ابدی که به فرد اجازه می‌دهد انرژی‌های Abyss را کنترل کند. استفاده از این مهارت نیاز به مانا و تمرکز بالا دارد.	Abyss	117	5
skill_volcanic_045	باران گدازه سنگ جهنمی	مهارت باران گدازه سنگ جهنمی که به فرد اجازه می‌دهد انرژی‌های Volcanic را کنترل کند. استفاده از این مهارت نیاز به مانا و تمرکز بالا دارد.	Volcanic	35	7
skill_glacial_046	لمس سرما سرمای استخوان‌سوز	مهارت لمس سرما سرمای استخوان‌سوز که به فرد اجازه می‌دهد انرژی‌های Glacial را کنترل کند. استفاده از این مهارت نیاز به مانا و تمرکز بالا دارد.	Glacial	104	4
skill_arcane_047	تله‌پورت کوتاه انرژی‌های کیهانی	مهارت تله‌پورت کوتاه انرژی‌های کیهانی که به فرد اجازه می‌دهد انرژی‌های Arcane را کنترل کند. استفاده از این مهارت نیاز به مانا و تمرکز بالا دارد.	Arcane	65	3
skill_abyss_048	انفجار خلاء خلاء	مهارت انفجار خلاء خلاء که به فرد اجازه می‌دهد انرژی‌های Abyss را کنترل کند. استفاده از این مهارت نیاز به مانا و تمرکز بالا دارد.	Abyss	13	5
skill_volcanic_049	پوست سنگی سوزان سنگ جهنمی	مهارت پوست سنگی سوزان سنگ جهنمی که به فرد اجازه می‌دهد انرژی‌های Volcanic را کنترل کند. استفاده از این مهارت نیاز به مانا و تمرکز بالا دارد.	Volcanic	27	23
skill_glacial_050	نیزه یخی یخبندان شمالی	مهارت نیزه یخی یخبندان شمالی که به فرد اجازه می‌دهد انرژی‌های Glacial را کنترل کند. استفاده از این مهارت نیاز به مانا و تمرکز بالا دارد.	Glacial	107	22
skill_arcane_051	سپر کیهانی جادوی کهن	مهارت سپر کیهانی جادوی کهن که به فرد اجازه می‌دهد انرژی‌های Arcane را کنترل کند. استفاده از این مهارت نیاز به مانا و تمرکز بالا دارد.	Arcane	69	4
skill_abyss_052	طلسم تاریک خلاء	مهارت طلسم تاریک خلاء که به فرد اجازه می‌دهد انرژی‌های Abyss را کنترل کند. استفاده از این مهارت نیاز به مانا و تمرکز بالا دارد.	Abyss	116	3
skill_volcanic_053	انفجار حرارتی گدازه مذاب	مهارت انفجار حرارتی گدازه مذاب که به فرد اجازه می‌دهد انرژی‌های Volcanic را کنترل کند. استفاده از این مهارت نیاز به مانا و تمرکز بالا دارد.	Volcanic	110	20
skill_glacial_054	طوفان کولاک زمستان تاریک	مهارت طوفان کولاک زمستان تاریک که به فرد اجازه می‌دهد انرژی‌های Glacial را کنترل کند. استفاده از این مهارت نیاز به مانا و تمرکز بالا دارد.	Glacial	20	8
skill_arcane_055	تله‌پورت کوتاه جادوی کهن	مهارت تله‌پورت کوتاه جادوی کهن که به فرد اجازه می‌دهد انرژی‌های Arcane را کنترل کند. استفاده از این مهارت نیاز به مانا و تمرکز بالا دارد.	Arcane	56	20
skill_abyss_056	انفجار خلاء مرگ ابدی	مهارت انفجار خلاء مرگ ابدی که به فرد اجازه می‌دهد انرژی‌های Abyss را کنترل کند. استفاده از این مهارت نیاز به مانا و تمرکز بالا دارد.	Abyss	51	10
skill_volcanic_057	انفجار حرارتی خاکستر سرخ	مهارت انفجار حرارتی خاکستر سرخ که به فرد اجازه می‌دهد انرژی‌های Volcanic را کنترل کند. استفاده از این مهارت نیاز به مانا و تمرکز بالا دارد.	Volcanic	101	19
skill_glacial_058	طوفان کولاک کولاک ابدی	مهارت طوفان کولاک کولاک ابدی که به فرد اجازه می‌دهد انرژی‌های Glacial را کنترل کند. استفاده از این مهارت نیاز به مانا و تمرکز بالا دارد.	Glacial	80	11
skill_arcane_059	پیکان مانا انرژی‌های کیهانی	مهارت پیکان مانا انرژی‌های کیهانی که به فرد اجازه می‌دهد انرژی‌های Arcane را کنترل کند. استفاده از این مهارت نیاز به مانا و تمرکز بالا دارد.	Arcane	120	3
skill_abyss_060	سپر سایه‌ها فاسد شده	مهارت سپر سایه‌ها فاسد شده که به فرد اجازه می‌دهد انرژی‌های Abyss را کنترل کند. استفاده از این مهارت نیاز به مانا و تمرکز بالا دارد.	Abyss	37	6
skill_volcanic_061	انفجار حرارتی آتشفشان	مهارت انفجار حرارتی آتشفشان که به فرد اجازه می‌دهد انرژی‌های Volcanic را کنترل کند. استفاده از این مهارت نیاز به مانا و تمرکز بالا دارد.	Volcanic	10	15
skill_glacial_062	حصار منجمد کولاک ابدی	مهارت حصار منجمد کولاک ابدی که به فرد اجازه می‌دهد انرژی‌های Glacial را کنترل کند. استفاده از این مهارت نیاز به مانا و تمرکز بالا دارد.	Glacial	76	7
skill_arcane_063	تله‌پورت کوتاه انرژی‌های کیهانی	مهارت تله‌پورت کوتاه انرژی‌های کیهانی که به فرد اجازه می‌دهد انرژی‌های Arcane را کنترل کند. استفاده از این مهارت نیاز به مانا و تمرکز بالا دارد.	Arcane	44	29
skill_abyss_064	طلسم تاریک فاسد شده	مهارت طلسم تاریک فاسد شده که به فرد اجازه می‌دهد انرژی‌های Abyss را کنترل کند. استفاده از این مهارت نیاز به مانا و تمرکز بالا دارد.	Abyss	50	24
skill_volcanic_065	شلاق شعله‌ور سنگ جهنمی	مهارت شلاق شعله‌ور سنگ جهنمی که به فرد اجازه می‌دهد انرژی‌های Volcanic را کنترل کند. استفاده از این مهارت نیاز به مانا و تمرکز بالا دارد.	Volcanic	67	3
skill_glacial_066	نیزه یخی سرمای استخوان‌سوز	مهارت نیزه یخی سرمای استخوان‌سوز که به فرد اجازه می‌دهد انرژی‌های Glacial را کنترل کند. استفاده از این مهارت نیاز به مانا و تمرکز بالا دارد.	Glacial	112	23
skill_arcane_067	پیکان مانا مانای سرکش	مهارت پیکان مانا مانای سرکش که به فرد اجازه می‌دهد انرژی‌های Arcane را کنترل کند. استفاده از این مهارت نیاز به مانا و تمرکز بالا دارد.	Arcane	32	11
skill_abyss_068	قدم زدن در تاریکی سایه‌های سرگردان	مهارت قدم زدن در تاریکی سایه‌های سرگردان که به فرد اجازه می‌دهد انرژی‌های Abyss را کنترل کند. استفاده از این مهارت نیاز به مانا و تمرکز بالا دارد.	Abyss	32	29
skill_volcanic_069	انفجار حرارتی گدازه مذاب	مهارت انفجار حرارتی گدازه مذاب که به فرد اجازه می‌دهد انرژی‌های Volcanic را کنترل کند. استفاده از این مهارت نیاز به مانا و تمرکز بالا دارد.	Volcanic	112	23
skill_glacial_070	حصار منجمد سرمای استخوان‌سوز	مهارت حصار منجمد سرمای استخوان‌سوز که به فرد اجازه می‌دهد انرژی‌های Glacial را کنترل کند. استفاده از این مهارت نیاز به مانا و تمرکز بالا دارد.	Glacial	56	5
skill_arcane_071	پیکان مانا انرژی‌های کیهانی	مهارت پیکان مانا انرژی‌های کیهانی که به فرد اجازه می‌دهد انرژی‌های Arcane را کنترل کند. استفاده از این مهارت نیاز به مانا و تمرکز بالا دارد.	Arcane	11	7
skill_abyss_072	سپر سایه‌ها خلاء	مهارت سپر سایه‌ها خلاء که به فرد اجازه می‌دهد انرژی‌های Abyss را کنترل کند. استفاده از این مهارت نیاز به مانا و تمرکز بالا دارد.	Abyss	70	7
skill_volcanic_073	پوست سنگی سوزان آتش ابدی	مهارت پوست سنگی سوزان آتش ابدی که به فرد اجازه می‌دهد انرژی‌های Volcanic را کنترل کند. استفاده از این مهارت نیاز به مانا و تمرکز بالا دارد.	Volcanic	62	27
skill_glacial_074	لمس سرما زمستان تاریک	مهارت لمس سرما زمستان تاریک که به فرد اجازه می‌دهد انرژی‌های Glacial را کنترل کند. استفاده از این مهارت نیاز به مانا و تمرکز بالا دارد.	Glacial	62	6
skill_arcane_075	تله‌پورت کوتاه انرژی‌های کیهانی	مهارت تله‌پورت کوتاه انرژی‌های کیهانی که به فرد اجازه می‌دهد انرژی‌های Arcane را کنترل کند. استفاده از این مهارت نیاز به مانا و تمرکز بالا دارد.	Arcane	52	26
skill_abyss_076	سپر سایه‌ها سایه‌های سرگردان	مهارت سپر سایه‌ها سایه‌های سرگردان که به فرد اجازه می‌دهد انرژی‌های Abyss را کنترل کند. استفاده از این مهارت نیاز به مانا و تمرکز بالا دارد.	Abyss	58	27
skill_volcanic_077	شلاق شعله‌ور گدازه مذاب	مهارت شلاق شعله‌ور گدازه مذاب که به فرد اجازه می‌دهد انرژی‌های Volcanic را کنترل کند. استفاده از این مهارت نیاز به مانا و تمرکز بالا دارد.	Volcanic	104	4
skill_glacial_078	حصار منجمد سرمای استخوان‌سوز	مهارت حصار منجمد سرمای استخوان‌سوز که به فرد اجازه می‌دهد انرژی‌های Glacial را کنترل کند. استفاده از این مهارت نیاز به مانا و تمرکز بالا دارد.	Glacial	30	28
skill_arcane_079	انفجار ستاره‌ای انرژی‌های کیهانی	مهارت انفجار ستاره‌ای انرژی‌های کیهانی که به فرد اجازه می‌دهد انرژی‌های Arcane را کنترل کند. استفاده از این مهارت نیاز به مانا و تمرکز بالا دارد.	Arcane	11	15
skill_abyss_080	قدم زدن در تاریکی فاسد شده	مهارت قدم زدن در تاریکی فاسد شده که به فرد اجازه می‌دهد انرژی‌های Abyss را کنترل کند. استفاده از این مهارت نیاز به مانا و تمرکز بالا دارد.	Abyss	20	9
skill_volcanic_081	انفجار حرارتی آتشفشان	مهارت انفجار حرارتی آتشفشان که به فرد اجازه می‌دهد انرژی‌های Volcanic را کنترل کند. استفاده از این مهارت نیاز به مانا و تمرکز بالا دارد.	Volcanic	110	18
skill_glacial_082	حصار منجمد زمستان تاریک	مهارت حصار منجمد زمستان تاریک که به فرد اجازه می‌دهد انرژی‌های Glacial را کنترل کند. استفاده از این مهارت نیاز به مانا و تمرکز بالا دارد.	Glacial	51	11
skill_arcane_083	تله‌پورت کوتاه مانای سرکش	مهارت تله‌پورت کوتاه مانای سرکش که به فرد اجازه می‌دهد انرژی‌های Arcane را کنترل کند. استفاده از این مهارت نیاز به مانا و تمرکز بالا دارد.	Arcane	41	22
skill_abyss_084	قدم زدن در تاریکی فاسد شده	مهارت قدم زدن در تاریکی فاسد شده که به فرد اجازه می‌دهد انرژی‌های Abyss را کنترل کند. استفاده از این مهارت نیاز به مانا و تمرکز بالا دارد.	Abyss	11	18
skill_volcanic_085	باران گدازه آتش ابدی	مهارت باران گدازه آتش ابدی که به فرد اجازه می‌دهد انرژی‌های Volcanic را کنترل کند. استفاده از این مهارت نیاز به مانا و تمرکز بالا دارد.	Volcanic	31	16
skill_glacial_086	نیزه یخی سرمای استخوان‌سوز	مهارت نیزه یخی سرمای استخوان‌سوز که به فرد اجازه می‌دهد انرژی‌های Glacial را کنترل کند. استفاده از این مهارت نیاز به مانا و تمرکز بالا دارد.	Glacial	99	22
skill_arcane_087	سپر کیهانی اسرار باستانی	مهارت سپر کیهانی اسرار باستانی که به فرد اجازه می‌دهد انرژی‌های Arcane را کنترل کند. استفاده از این مهارت نیاز به مانا و تمرکز بالا دارد.	Arcane	108	20
skill_abyss_088	انفجار خلاء سایه‌های سرگردان	مهارت انفجار خلاء سایه‌های سرگردان که به فرد اجازه می‌دهد انرژی‌های Abyss را کنترل کند. استفاده از این مهارت نیاز به مانا و تمرکز بالا دارد.	Abyss	109	6
skill_volcanic_089	باران گدازه سنگ جهنمی	مهارت باران گدازه سنگ جهنمی که به فرد اجازه می‌دهد انرژی‌های Volcanic را کنترل کند. استفاده از این مهارت نیاز به مانا و تمرکز بالا دارد.	Volcanic	10	25
skill_glacial_090	طوفان کولاک زمستان تاریک	مهارت طوفان کولاک زمستان تاریک که به فرد اجازه می‌دهد انرژی‌های Glacial را کنترل کند. استفاده از این مهارت نیاز به مانا و تمرکز بالا دارد.	Glacial	54	4
skill_arcane_091	انفجار ستاره‌ای مانای سرکش	مهارت انفجار ستاره‌ای مانای سرکش که به فرد اجازه می‌دهد انرژی‌های Arcane را کنترل کند. استفاده از این مهارت نیاز به مانا و تمرکز بالا دارد.	Arcane	10	10
skill_abyss_092	سپر سایه‌ها خلاء	مهارت سپر سایه‌ها خلاء که به فرد اجازه می‌دهد انرژی‌های Abyss را کنترل کند. استفاده از این مهارت نیاز به مانا و تمرکز بالا دارد.	Abyss	116	18
skill_volcanic_093	انفجار حرارتی آتش ابدی	مهارت انفجار حرارتی آتش ابدی که به فرد اجازه می‌دهد انرژی‌های Volcanic را کنترل کند. استفاده از این مهارت نیاز به مانا و تمرکز بالا دارد.	Volcanic	88	6
skill_glacial_094	نیزه یخی سرمای استخوان‌سوز	مهارت نیزه یخی سرمای استخوان‌سوز که به فرد اجازه می‌دهد انرژی‌های Glacial را کنترل کند. استفاده از این مهارت نیاز به مانا و تمرکز بالا دارد.	Glacial	36	30
skill_arcane_095	انفجار ستاره‌ای مانای سرکش	مهارت انفجار ستاره‌ای مانای سرکش که به فرد اجازه می‌دهد انرژی‌های Arcane را کنترل کند. استفاده از این مهارت نیاز به مانا و تمرکز بالا دارد.	Arcane	80	2
skill_abyss_096	سپر سایه‌ها سایه‌های سرگردان	مهارت سپر سایه‌ها سایه‌های سرگردان که به فرد اجازه می‌دهد انرژی‌های Abyss را کنترل کند. استفاده از این مهارت نیاز به مانا و تمرکز بالا دارد.	Abyss	107	20
skill_volcanic_097	پوست سنگی سوزان گدازه مذاب	مهارت پوست سنگی سوزان گدازه مذاب که به فرد اجازه می‌دهد انرژی‌های Volcanic را کنترل کند. استفاده از این مهارت نیاز به مانا و تمرکز بالا دارد.	Volcanic	49	25
skill_glacial_098	لمس سرما بلورهای جادویی	مهارت لمس سرما بلورهای جادویی که به فرد اجازه می‌دهد انرژی‌های Glacial را کنترل کند. استفاده از این مهارت نیاز به مانا و تمرکز بالا دارد.	Glacial	40	14
skill_arcane_099	انفجار ستاره‌ای انرژی‌های کیهانی	مهارت انفجار ستاره‌ای انرژی‌های کیهانی که به فرد اجازه می‌دهد انرژی‌های Arcane را کنترل کند. استفاده از این مهارت نیاز به مانا و تمرکز بالا دارد.	Arcane	78	27
\.


--
-- Data for Name: skill_discovery_rule; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.skill_discovery_rule (skill_id, activity_type, base_chance, rarity, talent_bonus) FROM stdin;
skill_abyss_000	combat	0.0794	Epic	{"bonus_chance": 0.05}
skill_volcanic_001	exploration	0.1110	Epic	{"bonus_chance": 0.05}
skill_glacial_002	exploration	0.0622	Epic	{"bonus_chance": 0.05}
skill_arcane_003	combat	0.1113	Rare	{"bonus_chance": 0.05}
skill_abyss_004	study_black_knowledge	0.0420	Common	{"bonus_chance": 0.05}
skill_volcanic_005	exploration	0.1043	Common	{"bonus_chance": 0.05}
skill_glacial_006	combat	0.1133	Epic	{"bonus_chance": 0.05}
skill_arcane_007	combat	0.1079	Rare	{"bonus_chance": 0.05}
skill_abyss_008	combat	0.1271	Common	{"bonus_chance": 0.05}
skill_volcanic_009	study_black_knowledge	0.0857	Epic	{"bonus_chance": 0.05}
skill_glacial_010	study_black_knowledge	0.0744	Rare	{"bonus_chance": 0.05}
skill_arcane_011	combat	0.1457	Rare	{"bonus_chance": 0.05}
skill_abyss_012	combat	0.1303	Rare	{"bonus_chance": 0.05}
skill_volcanic_013	exploration	0.0439	Epic	{"bonus_chance": 0.05}
skill_glacial_014	combat	0.1364	Common	{"bonus_chance": 0.05}
skill_arcane_015	exploration	0.1202	Epic	{"bonus_chance": 0.05}
skill_abyss_016	study_black_knowledge	0.0309	Rare	{"bonus_chance": 0.05}
skill_volcanic_017	exploration	0.0294	Rare	{"bonus_chance": 0.05}
skill_glacial_018	study_black_knowledge	0.0488	Common	{"bonus_chance": 0.05}
skill_arcane_019	combat	0.0353	Common	{"bonus_chance": 0.05}
skill_abyss_020	study_black_knowledge	0.0198	Epic	{"bonus_chance": 0.05}
skill_volcanic_021	hunting	0.0718	Epic	{"bonus_chance": 0.05}
skill_glacial_022	exploration	0.0266	Common	{"bonus_chance": 0.05}
skill_arcane_023	combat	0.1409	Epic	{"bonus_chance": 0.05}
skill_abyss_024	exploration	0.0555	Epic	{"bonus_chance": 0.05}
skill_volcanic_025	study_black_knowledge	0.0708	Common	{"bonus_chance": 0.05}
skill_glacial_026	hunting	0.1176	Epic	{"bonus_chance": 0.05}
skill_arcane_027	combat	0.0583	Common	{"bonus_chance": 0.05}
skill_abyss_028	study_black_knowledge	0.0218	Epic	{"bonus_chance": 0.05}
skill_volcanic_029	hunting	0.1016	Rare	{"bonus_chance": 0.05}
skill_glacial_030	study_black_knowledge	0.0163	Epic	{"bonus_chance": 0.05}
skill_arcane_031	combat	0.1278	Rare	{"bonus_chance": 0.05}
skill_abyss_032	exploration	0.1396	Common	{"bonus_chance": 0.05}
skill_volcanic_033	combat	0.0486	Epic	{"bonus_chance": 0.05}
skill_glacial_034	combat	0.0375	Rare	{"bonus_chance": 0.05}
skill_arcane_035	hunting	0.1203	Common	{"bonus_chance": 0.05}
skill_abyss_036	study_black_knowledge	0.0761	Common	{"bonus_chance": 0.05}
skill_volcanic_037	study_black_knowledge	0.0662	Rare	{"bonus_chance": 0.05}
skill_glacial_038	study_black_knowledge	0.1280	Rare	{"bonus_chance": 0.05}
skill_arcane_039	study_black_knowledge	0.0928	Common	{"bonus_chance": 0.05}
skill_abyss_040	exploration	0.0708	Common	{"bonus_chance": 0.05}
skill_volcanic_041	exploration	0.0320	Common	{"bonus_chance": 0.05}
skill_glacial_042	combat	0.0323	Rare	{"bonus_chance": 0.05}
skill_arcane_043	exploration	0.0150	Epic	{"bonus_chance": 0.05}
skill_abyss_044	exploration	0.0791	Common	{"bonus_chance": 0.05}
skill_volcanic_045	study_black_knowledge	0.0828	Common	{"bonus_chance": 0.05}
skill_glacial_046	exploration	0.1202	Rare	{"bonus_chance": 0.05}
skill_arcane_047	hunting	0.0286	Rare	{"bonus_chance": 0.05}
skill_abyss_048	hunting	0.0927	Common	{"bonus_chance": 0.05}
skill_volcanic_049	combat	0.0833	Rare	{"bonus_chance": 0.05}
skill_glacial_050	exploration	0.0723	Epic	{"bonus_chance": 0.05}
skill_arcane_051	study_black_knowledge	0.1452	Epic	{"bonus_chance": 0.05}
skill_abyss_052	combat	0.0839	Rare	{"bonus_chance": 0.05}
skill_volcanic_053	exploration	0.0831	Epic	{"bonus_chance": 0.05}
skill_glacial_054	combat	0.1039	Common	{"bonus_chance": 0.05}
skill_arcane_055	combat	0.1356	Epic	{"bonus_chance": 0.05}
skill_abyss_056	hunting	0.0305	Epic	{"bonus_chance": 0.05}
skill_volcanic_057	exploration	0.0308	Common	{"bonus_chance": 0.05}
skill_glacial_058	combat	0.1281	Epic	{"bonus_chance": 0.05}
skill_arcane_059	exploration	0.0132	Rare	{"bonus_chance": 0.05}
skill_abyss_060	hunting	0.1278	Rare	{"bonus_chance": 0.05}
skill_volcanic_061	combat	0.0560	Epic	{"bonus_chance": 0.05}
skill_glacial_062	combat	0.1223	Epic	{"bonus_chance": 0.05}
skill_arcane_063	study_black_knowledge	0.0292	Common	{"bonus_chance": 0.05}
skill_abyss_064	study_black_knowledge	0.0124	Rare	{"bonus_chance": 0.05}
skill_volcanic_065	exploration	0.0860	Common	{"bonus_chance": 0.05}
skill_glacial_066	exploration	0.1007	Epic	{"bonus_chance": 0.05}
skill_arcane_067	combat	0.0680	Rare	{"bonus_chance": 0.05}
skill_abyss_068	study_black_knowledge	0.0957	Rare	{"bonus_chance": 0.05}
skill_volcanic_069	study_black_knowledge	0.0423	Rare	{"bonus_chance": 0.05}
skill_glacial_070	combat	0.0279	Common	{"bonus_chance": 0.05}
skill_arcane_071	study_black_knowledge	0.0157	Common	{"bonus_chance": 0.05}
skill_abyss_072	combat	0.0817	Common	{"bonus_chance": 0.05}
skill_volcanic_073	exploration	0.0754	Rare	{"bonus_chance": 0.05}
skill_glacial_074	study_black_knowledge	0.0911	Rare	{"bonus_chance": 0.05}
skill_arcane_075	study_black_knowledge	0.0641	Epic	{"bonus_chance": 0.05}
skill_abyss_076	exploration	0.0273	Rare	{"bonus_chance": 0.05}
skill_volcanic_077	combat	0.0567	Rare	{"bonus_chance": 0.05}
skill_glacial_078	combat	0.1114	Common	{"bonus_chance": 0.05}
skill_arcane_079	hunting	0.1477	Common	{"bonus_chance": 0.05}
skill_abyss_080	exploration	0.0732	Common	{"bonus_chance": 0.05}
skill_volcanic_081	study_black_knowledge	0.0187	Common	{"bonus_chance": 0.05}
skill_glacial_082	exploration	0.1070	Epic	{"bonus_chance": 0.05}
skill_arcane_083	combat	0.0657	Common	{"bonus_chance": 0.05}
skill_abyss_084	exploration	0.0675	Common	{"bonus_chance": 0.05}
skill_volcanic_085	exploration	0.0577	Epic	{"bonus_chance": 0.05}
skill_glacial_086	hunting	0.0577	Epic	{"bonus_chance": 0.05}
skill_arcane_087	exploration	0.0733	Common	{"bonus_chance": 0.05}
skill_abyss_088	combat	0.0918	Common	{"bonus_chance": 0.05}
skill_volcanic_089	combat	0.0727	Common	{"bonus_chance": 0.05}
skill_glacial_090	study_black_knowledge	0.0104	Rare	{"bonus_chance": 0.05}
skill_arcane_091	study_black_knowledge	0.0710	Epic	{"bonus_chance": 0.05}
skill_abyss_092	study_black_knowledge	0.0490	Rare	{"bonus_chance": 0.05}
skill_volcanic_093	combat	0.0145	Rare	{"bonus_chance": 0.05}
skill_glacial_094	exploration	0.1125	Rare	{"bonus_chance": 0.05}
skill_arcane_095	exploration	0.0695	Common	{"bonus_chance": 0.05}
skill_abyss_096	combat	0.0522	Rare	{"bonus_chance": 0.05}
skill_volcanic_097	study_black_knowledge	0.0472	Rare	{"bonus_chance": 0.05}
skill_glacial_098	combat	0.0691	Epic	{"bonus_chance": 0.05}
skill_arcane_099	hunting	0.1216	Common	{"bonus_chance": 0.05}
\.


--
-- Data for Name: world_environment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.world_environment (environment_id, location_id, weather_type, active_buffs_json, started_at, ends_at) FROM stdin;
\.


--
-- Data for Name: world_events; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.world_events (id, event_type, description, created_at) FROM stdin;
\.


--
-- Data for Name: world_links; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.world_links (id, source_location_id, target_location_id, link_type, is_active, mana_cost, metadata, required_item_id) FROM stdin;
0	loc_abyss_000	loc_volcanic_001	portal	t	10	\N	item_volcanic_089
1	loc_volcanic_001	loc_glacial_002	portal	t	6	\N	\N
2	loc_glacial_002	loc_arcane_003	bridge	t	0	\N	\N
3	loc_arcane_003	loc_abyss_004	bridge	t	49	\N	\N
4	loc_abyss_004	loc_volcanic_005	bridge	t	50	\N	\N
5	loc_volcanic_005	loc_glacial_006	pathway	t	49	\N	item_arcane_111
6	loc_glacial_006	loc_arcane_007	pathway	t	40	\N	\N
7	loc_arcane_007	loc_abyss_008	portal	t	42	\N	\N
8	loc_abyss_008	loc_volcanic_009	pathway	t	49	\N	\N
9	loc_volcanic_009	loc_glacial_010	portal	t	13	\N	\N
10	loc_glacial_010	loc_arcane_011	bridge	t	33	\N	item_glacial_034
11	loc_arcane_011	loc_abyss_012	pathway	t	43	\N	\N
12	loc_abyss_012	loc_volcanic_013	pathway	t	45	\N	\N
13	loc_volcanic_013	loc_glacial_014	pathway	t	46	\N	\N
14	loc_glacial_014	loc_arcane_015	bridge	t	40	\N	\N
15	loc_arcane_015	loc_abyss_016	bridge	t	35	\N	item_volcanic_085
16	loc_abyss_016	loc_volcanic_017	bridge	t	41	\N	\N
17	loc_volcanic_017	loc_glacial_018	bridge	t	44	\N	\N
18	loc_glacial_018	loc_arcane_019	portal	t	10	\N	\N
19	loc_arcane_019	loc_abyss_020	bridge	t	21	\N	\N
20	loc_abyss_020	loc_volcanic_021	pathway	t	47	\N	item_volcanic_073
21	loc_volcanic_021	loc_glacial_022	pathway	t	41	\N	\N
22	loc_glacial_022	loc_arcane_023	bridge	t	16	\N	\N
23	loc_arcane_023	loc_abyss_024	portal	t	9	\N	\N
24	loc_abyss_024	loc_volcanic_025	portal	t	34	\N	\N
25	loc_volcanic_025	loc_glacial_026	pathway	t	19	\N	item_glacial_050
26	loc_glacial_026	loc_arcane_027	pathway	t	35	\N	\N
27	loc_arcane_027	loc_abyss_028	pathway	t	46	\N	\N
28	loc_abyss_028	loc_volcanic_029	pathway	t	31	\N	\N
29	loc_volcanic_029	loc_glacial_030	pathway	t	45	\N	\N
30	loc_glacial_030	loc_arcane_031	portal	t	24	\N	item_abyss_132
31	loc_arcane_031	loc_abyss_032	portal	t	6	\N	\N
32	loc_abyss_032	loc_volcanic_033	pathway	t	48	\N	\N
33	loc_volcanic_033	loc_glacial_034	pathway	t	32	\N	\N
34	loc_glacial_034	loc_arcane_035	pathway	t	4	\N	\N
35	loc_arcane_035	loc_abyss_036	bridge	t	49	\N	item_arcane_015
36	loc_abyss_036	loc_volcanic_037	pathway	t	48	\N	\N
37	loc_volcanic_037	loc_glacial_038	bridge	t	2	\N	\N
38	loc_glacial_038	loc_arcane_039	portal	t	2	\N	\N
39	loc_arcane_039	loc_abyss_040	bridge	t	39	\N	\N
40	loc_abyss_040	loc_volcanic_041	bridge	t	2	\N	item_arcane_071
41	loc_volcanic_041	loc_glacial_042	portal	t	38	\N	\N
42	loc_glacial_042	loc_arcane_043	portal	t	7	\N	\N
43	loc_arcane_043	loc_abyss_044	portal	t	1	\N	\N
44	loc_abyss_044	loc_volcanic_045	portal	t	27	\N	\N
45	loc_volcanic_045	loc_glacial_046	pathway	t	43	\N	item_abyss_124
46	loc_glacial_046	loc_arcane_047	bridge	t	19	\N	\N
47	loc_arcane_047	loc_abyss_048	pathway	t	50	\N	\N
48	loc_abyss_048	loc_volcanic_049	bridge	t	11	\N	\N
49	loc_volcanic_049	loc_glacial_050	portal	t	50	\N	\N
\.


--
-- Data for Name: world_objects; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.world_objects (id, location_id, object_type, state, interaction_logic, last_interacted_at, respawn_time_seconds) FROM stdin;
\.


--
-- Data for Name: world_rules; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.world_rules (id, rule_key, rule_value, affected_location_id, affected_civilization_id, expires_at) FROM stdin;
49	xp_multiplier_abyss	1.50	loc_abyss_000	\N	2026-06-13 11:31:56.846349+00
49	hunting_bonus_great_man	1.25	\N	1	2026-06-09 11:31:56.846652+00
\.


--
-- Name: civilizations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.civilizations_id_seq', 1, false);


--
-- Name: world_events_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.world_events_id_seq', 1, false);


--
-- Name: world_links_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.world_links_id_seq', 50, true);


--
-- Name: world_objects_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.world_objects_id_seq', 1, false);


--
-- Name: world_rules_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.world_rules_id_seq', 4, true);


--
-- Name: achievement achievement_code_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.achievement
    ADD CONSTRAINT achievement_code_key UNIQUE (code);


--
-- Name: achievement achievement_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.achievement
    ADD CONSTRAINT achievement_pkey PRIMARY KEY (achievement_id);


--
-- Name: battle_log battle_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.battle_log
    ADD CONSTRAINT battle_log_pkey PRIMARY KEY (battle_id);


--
-- Name: character_achievement character_achievement_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.character_achievement
    ADD CONSTRAINT character_achievement_pkey PRIMARY KEY (character_id, achievement_id);


--
-- Name: character character_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."character"
    ADD CONSTRAINT character_pkey PRIMARY KEY (character_id);


--
-- Name: character_quest character_quest_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.character_quest
    ADD CONSTRAINT character_quest_pkey PRIMARY KEY (character_id, quest_id);


--
-- Name: character_skill character_skill_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.character_skill
    ADD CONSTRAINT character_skill_pkey PRIMARY KEY (character_id, skill_id);


--
-- Name: civilizations civilizations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.civilizations
    ADD CONSTRAINT civilizations_pkey PRIMARY KEY (id);


--
-- Name: civilizations civilizations_slug_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.civilizations
    ADD CONSTRAINT civilizations_slug_key UNIQUE (slug);


--
-- Name: clan_member clan_member_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clan_member
    ADD CONSTRAINT clan_member_pkey PRIMARY KEY (clan_id, character_id);


--
-- Name: clan clan_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clan
    ADD CONSTRAINT clan_pkey PRIMARY KEY (clan_id);


--
-- Name: cooldowns cooldowns_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cooldowns
    ADD CONSTRAINT cooldowns_pkey PRIMARY KEY (cooldown_id);


--
-- Name: dungeon_enemy_config dungeon_enemy_config_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dungeon_enemy_config
    ADD CONSTRAINT dungeon_enemy_config_pkey PRIMARY KEY (dungeon_id, enemy_id);


--
-- Name: dungeon_item_config dungeon_item_config_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dungeon_item_config
    ADD CONSTRAINT dungeon_item_config_pkey PRIMARY KEY (dungeon_id, item_id);


--
-- Name: dungeon dungeon_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dungeon
    ADD CONSTRAINT dungeon_pkey PRIMARY KEY (dungeon_id);


--
-- Name: economy_ledger economy_ledger_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.economy_ledger
    ADD CONSTRAINT economy_ledger_pkey PRIMARY KEY (ledger_id);


--
-- Name: enemy_instance enemy_instance_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enemy_instance
    ADD CONSTRAINT enemy_instance_pkey PRIMARY KEY (instance_id);


--
-- Name: enemy enemy_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enemy
    ADD CONSTRAINT enemy_pkey PRIMARY KEY (enemy_id);


--
-- Name: enemy_stats enemy_stats_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enemy_stats
    ADD CONSTRAINT enemy_stats_pkey PRIMARY KEY (enemy_id);


--
-- Name: equipment equipment_item_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.equipment
    ADD CONSTRAINT equipment_item_id_key UNIQUE (item_id);


--
-- Name: equipment equipment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.equipment
    ADD CONSTRAINT equipment_pkey PRIMARY KEY (equipment_id);


--
-- Name: event_history event_history_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_history
    ADD CONSTRAINT event_history_pkey PRIMARY KEY (event_id);


--
-- Name: family_background family_background_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.family_background
    ADD CONSTRAINT family_background_pkey PRIMARY KEY (background_id);


--
-- Name: guild_member guild_member_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.guild_member
    ADD CONSTRAINT guild_member_pkey PRIMARY KEY (guild_id, character_id);


--
-- Name: guild guild_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.guild
    ADD CONSTRAINT guild_pkey PRIMARY KEY (guild_id);


--
-- Name: inventory inventory_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventory
    ADD CONSTRAINT inventory_pkey PRIMARY KEY (character_id, item_id);


--
-- Name: item item_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.item
    ADD CONSTRAINT item_pkey PRIMARY KEY (item_id);


--
-- Name: location_feature location_feature_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.location_feature
    ADD CONSTRAINT location_feature_pkey PRIMARY KEY (feature_id);


--
-- Name: location location_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.location
    ADD CONSTRAINT location_pkey PRIMARY KEY (location_id);


--
-- Name: login_history login_history_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.login_history
    ADD CONSTRAINT login_history_pkey PRIMARY KEY (login_history_id);


--
-- Name: market_listing market_listing_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.market_listing
    ADD CONSTRAINT market_listing_pkey PRIMARY KEY (listing_id);


--
-- Name: message message_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.message
    ADD CONSTRAINT message_pkey PRIMARY KEY (message_id);


--
-- Name: notification notification_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notification
    ADD CONSTRAINT notification_pkey PRIMARY KEY (notification_id);


--
-- Name: npc_interaction_rule npc_interaction_rule_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.npc_interaction_rule
    ADD CONSTRAINT npc_interaction_rule_pkey PRIMARY KEY (rule_id);


--
-- Name: npc_merchant_stock npc_merchant_stock_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.npc_merchant_stock
    ADD CONSTRAINT npc_merchant_stock_pkey PRIMARY KEY (npc_id, item_id);


--
-- Name: npc npc_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.npc
    ADD CONSTRAINT npc_pkey PRIMARY KEY (npc_id);


--
-- Name: npc_stats npc_stats_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.npc_stats
    ADD CONSTRAINT npc_stats_pkey PRIMARY KEY (npc_id);


--
-- Name: party_member party_member_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.party_member
    ADD CONSTRAINT party_member_pkey PRIMARY KEY (party_id, character_id);


--
-- Name: party party_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.party
    ADD CONSTRAINT party_pkey PRIMARY KEY (party_id);


--
-- Name: player_mail player_mail_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.player_mail
    ADD CONSTRAINT player_mail_pkey PRIMARY KEY (mail_id);


--
-- Name: player_session player_session_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.player_session
    ADD CONSTRAINT player_session_pkey PRIMARY KEY (session_id);


--
-- Name: character_stats player_stats_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.character_stats
    ADD CONSTRAINT player_stats_pkey PRIMARY KEY (character_id) INCLUDE (character_id);


--
-- Name: player_wallet player_wallet_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.player_wallet
    ADD CONSTRAINT player_wallet_pkey PRIMARY KEY (wallet_id);


--
-- Name: player_wallet player_wallet_player_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.player_wallet
    ADD CONSTRAINT player_wallet_player_id_key UNIQUE (player_id);


--
-- Name: quest quest_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quest
    ADD CONSTRAINT quest_pkey PRIMARY KEY (quest_id);


--
-- Name: race race_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.race
    ADD CONSTRAINT race_pkey PRIMARY KEY (race_id);


--
-- Name: rank rank_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rank
    ADD CONSTRAINT rank_pkey PRIMARY KEY (rank_id);


--
-- Name: skill_discovery_rule skill_discovery_rule_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.skill_discovery_rule
    ADD CONSTRAINT skill_discovery_rule_pkey PRIMARY KEY (skill_id, activity_type, rarity);


--
-- Name: skill skill_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.skill
    ADD CONSTRAINT skill_pkey PRIMARY KEY (skill_id);


--
-- Name: player users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.player
    ADD CONSTRAINT users_pkey PRIMARY KEY (player_id);


--
-- Name: world_environment world_environment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.world_environment
    ADD CONSTRAINT world_environment_pkey PRIMARY KEY (environment_id);


--
-- Name: world_events world_events_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.world_events
    ADD CONSTRAINT world_events_pkey PRIMARY KEY (id);


--
-- Name: world_links world_links_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.world_links
    ADD CONSTRAINT world_links_pkey PRIMARY KEY (id);


--
-- Name: world_objects world_objects_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.world_objects
    ADD CONSTRAINT world_objects_pkey PRIMARY KEY (id);


--
-- Name: world_rules world_rules_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.world_rules
    ADD CONSTRAINT world_rules_pkey PRIMARY KEY (id, rule_key, rule_value);


--
-- Name: world_rules world_rules_rule_key_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.world_rules
    ADD CONSTRAINT world_rules_rule_key_key UNIQUE (rule_key);


--
-- Name: battle_log battle_log_character_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.battle_log
    ADD CONSTRAINT battle_log_character_id_fkey FOREIGN KEY (character_id) REFERENCES public."character"(character_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: battle_log battle_log_enemy_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.battle_log
    ADD CONSTRAINT battle_log_enemy_id_fkey FOREIGN KEY (enemy_id) REFERENCES public.enemy(enemy_id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- Name: character_achievement character_achievement_achievement_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.character_achievement
    ADD CONSTRAINT character_achievement_achievement_id_fkey FOREIGN KEY (achievement_id) REFERENCES public.achievement(achievement_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: character_achievement character_achievement_character_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.character_achievement
    ADD CONSTRAINT character_achievement_character_id_fkey FOREIGN KEY (character_id) REFERENCES public."character"(character_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: character character_player_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."character"
    ADD CONSTRAINT character_player_id_fkey FOREIGN KEY (player_id) REFERENCES public.player(player_id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- Name: character_quest character_quest_character_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.character_quest
    ADD CONSTRAINT character_quest_character_id_fkey FOREIGN KEY (character_id) REFERENCES public."character"(character_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: character_quest character_quest_quest_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.character_quest
    ADD CONSTRAINT character_quest_quest_id_fkey FOREIGN KEY (quest_id) REFERENCES public.quest(quest_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: character character_rank_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."character"
    ADD CONSTRAINT character_rank_id_fkey FOREIGN KEY (rank_id) REFERENCES public.rank(rank_id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- Name: character_skill character_skill_character_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.character_skill
    ADD CONSTRAINT character_skill_character_id_fkey FOREIGN KEY (character_id) REFERENCES public."character"(character_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: character_skill character_skill_skill_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.character_skill
    ADD CONSTRAINT character_skill_skill_id_fkey FOREIGN KEY (skill_id) REFERENCES public.skill(skill_id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- Name: clan clan_leader_character_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clan
    ADD CONSTRAINT clan_leader_character_id_fkey FOREIGN KEY (leader_character_id) REFERENCES public."character"(character_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: clan_member clan_member_character_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clan_member
    ADD CONSTRAINT clan_member_character_id_fkey FOREIGN KEY (character_id) REFERENCES public."character"(character_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: clan_member clan_member_clan_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clan_member
    ADD CONSTRAINT clan_member_clan_id_fkey FOREIGN KEY (clan_id) REFERENCES public.clan(clan_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: cooldowns cooldowns_character_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cooldowns
    ADD CONSTRAINT cooldowns_character_id_fkey FOREIGN KEY (character_id) REFERENCES public."character"(character_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: cooldowns cooldowns_skill_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cooldowns
    ADD CONSTRAINT cooldowns_skill_id_fkey FOREIGN KEY (skill_id) REFERENCES public.skill(skill_id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: dungeon_enemy_config dungeon_enemy_config_dungeon_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dungeon_enemy_config
    ADD CONSTRAINT dungeon_enemy_config_dungeon_id_fkey FOREIGN KEY (dungeon_id) REFERENCES public.dungeon(dungeon_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: dungeon_enemy_config dungeon_enemy_config_enemy_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dungeon_enemy_config
    ADD CONSTRAINT dungeon_enemy_config_enemy_id_fkey FOREIGN KEY (enemy_id) REFERENCES public.enemy(enemy_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: dungeon_item_config dungeon_item_config_dungeon_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dungeon_item_config
    ADD CONSTRAINT dungeon_item_config_dungeon_id_fkey FOREIGN KEY (dungeon_id) REFERENCES public.dungeon(dungeon_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: dungeon_item_config dungeon_item_config_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dungeon_item_config
    ADD CONSTRAINT dungeon_item_config_item_id_fkey FOREIGN KEY (item_id) REFERENCES public.item(item_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: economy_ledger economy_ledger_player_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.economy_ledger
    ADD CONSTRAINT economy_ledger_player_id_fkey FOREIGN KEY (player_id) REFERENCES public.player(player_id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: economy_ledger economy_ledger_wallet_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.economy_ledger
    ADD CONSTRAINT economy_ledger_wallet_id_fkey FOREIGN KEY (wallet_id) REFERENCES public.player_wallet(wallet_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: enemy_instance enemy_instance_enemy_id _fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enemy_instance
    ADD CONSTRAINT "enemy_instance_enemy_id _fkey" FOREIGN KEY (enemy_id) REFERENCES public.enemy(enemy_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: enemy_instance enemy_instance_location_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enemy_instance
    ADD CONSTRAINT enemy_instance_location_id_fkey FOREIGN KEY (location_id) REFERENCES public.location(location_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: enemy enemy_location_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enemy
    ADD CONSTRAINT enemy_location_id_fkey FOREIGN KEY (location_id) REFERENCES public.location(location_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: enemy enemy_rank_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enemy
    ADD CONSTRAINT enemy_rank_id_fkey FOREIGN KEY (rank_id) REFERENCES public.rank(rank_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: enemy_stats enemy_stats_enemy_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enemy_stats
    ADD CONSTRAINT enemy_stats_enemy_id_fkey FOREIGN KEY (enemy_id) REFERENCES public.enemy(enemy_id) NOT VALID;


--
-- Name: equipment equipment_character_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.equipment
    ADD CONSTRAINT equipment_character_id_fkey FOREIGN KEY (character_id) REFERENCES public."character"(character_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: equipment equipment_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.equipment
    ADD CONSTRAINT equipment_item_id_fkey FOREIGN KEY (item_id) REFERENCES public.item(item_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: event_history event_history_player_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_history
    ADD CONSTRAINT event_history_player_id_fkey FOREIGN KEY (player_id) REFERENCES public.player(player_id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- Name: civilizations fk_civilizations_starting_location; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.civilizations
    ADD CONSTRAINT fk_civilizations_starting_location FOREIGN KEY (starting_location_id) REFERENCES public.location(location_id);


--
-- Name: character_stats fk_player_stats_character; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.character_stats
    ADD CONSTRAINT fk_player_stats_character FOREIGN KEY (character_id) REFERENCES public."character"(character_id) ON DELETE CASCADE;


--
-- Name: world_links fk_world_links_required_item; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.world_links
    ADD CONSTRAINT fk_world_links_required_item FOREIGN KEY (required_item_id) REFERENCES public.item(item_id);


--
-- Name: guild guild_leader_character_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.guild
    ADD CONSTRAINT guild_leader_character_id_fkey FOREIGN KEY (leader_character_id) REFERENCES public."character"(character_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: guild_member guild_member_character_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.guild_member
    ADD CONSTRAINT guild_member_character_id_fkey FOREIGN KEY (character_id) REFERENCES public."character"(character_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: guild_member guild_member_guild_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.guild_member
    ADD CONSTRAINT guild_member_guild_id_fkey FOREIGN KEY (guild_id) REFERENCES public.guild(guild_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: inventory inventory_character_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventory
    ADD CONSTRAINT inventory_character_id_fkey FOREIGN KEY (character_id) REFERENCES public."character"(character_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: inventory inventory_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventory
    ADD CONSTRAINT inventory_item_id_fkey FOREIGN KEY (item_id) REFERENCES public.item(item_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: location_feature location_feature_location_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.location_feature
    ADD CONSTRAINT location_feature_location_id_fkey FOREIGN KEY (location_id) REFERENCES public.location(location_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: login_history login_history_player_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.login_history
    ADD CONSTRAINT login_history_player_id_fkey FOREIGN KEY (player_id) REFERENCES public.player(player_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: login_history login_history_session_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.login_history
    ADD CONSTRAINT login_history_session_id_fkey FOREIGN KEY (session_id) REFERENCES public.player_session(session_id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: player_mail mail_receiver_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.player_mail
    ADD CONSTRAINT mail_receiver_fkey FOREIGN KEY (receiver_id) REFERENCES public.player(player_id) ON DELETE CASCADE;


--
-- Name: market_listing market_seller_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.market_listing
    ADD CONSTRAINT market_seller_fkey FOREIGN KEY (seller_id) REFERENCES public.player(player_id) ON DELETE CASCADE;


--
-- Name: message message_receiver_character_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.message
    ADD CONSTRAINT message_receiver_character_id_fkey FOREIGN KEY (receiver_character_id) REFERENCES public."character"(character_id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: message message_receiver_player_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.message
    ADD CONSTRAINT message_receiver_player_id_fkey FOREIGN KEY (receiver_player_id) REFERENCES public.player(player_id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: message message_sender_character_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.message
    ADD CONSTRAINT message_sender_character_id_fkey FOREIGN KEY (sender_character_id) REFERENCES public."character"(character_id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: message message_sender_player_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.message
    ADD CONSTRAINT message_sender_player_id_fkey FOREIGN KEY (sender_player_id) REFERENCES public.player(player_id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: notification notification_character_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notification
    ADD CONSTRAINT notification_character_id_fkey FOREIGN KEY (character_id) REFERENCES public."character"(character_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: notification notification_player_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notification
    ADD CONSTRAINT notification_player_id_fkey FOREIGN KEY (player_id) REFERENCES public.player(player_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: npc npc_location_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.npc
    ADD CONSTRAINT npc_location_fkey FOREIGN KEY (base_location_id) REFERENCES public.location(location_id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: party party_leader_character_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.party
    ADD CONSTRAINT party_leader_character_id_fkey FOREIGN KEY (leader_character_id) REFERENCES public."character"(character_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: party_member party_member_character_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.party_member
    ADD CONSTRAINT party_member_character_id_fkey FOREIGN KEY (character_id) REFERENCES public."character"(character_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: party_member party_member_party_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.party_member
    ADD CONSTRAINT party_member_party_id_fkey FOREIGN KEY (party_id) REFERENCES public.party(party_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: player_session player_session_player_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.player_session
    ADD CONSTRAINT player_session_player_id_fkey FOREIGN KEY (player_id) REFERENCES public.player(player_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: player_state player_state_player_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.player_state
    ADD CONSTRAINT player_state_player_id_fkey FOREIGN KEY (player_id) REFERENCES public.player(player_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: character_stats player_stats_charecter_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.character_stats
    ADD CONSTRAINT player_stats_charecter_id_fkey FOREIGN KEY (character_id) REFERENCES public."character"(character_id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- Name: player_wallet player_wallet_player_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.player_wallet
    ADD CONSTRAINT player_wallet_player_id_fkey FOREIGN KEY (player_id) REFERENCES public.player(player_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: quest quest_difficulty_rank_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quest
    ADD CONSTRAINT quest_difficulty_rank_fkey FOREIGN KEY (difficulty_rank) REFERENCES public.rank(rank_id) NOT VALID;


--
-- Name: quest quest_location_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quest
    ADD CONSTRAINT quest_location_id_fkey FOREIGN KEY (location_id) REFERENCES public.location(location_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: race race_civilization_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.race
    ADD CONSTRAINT race_civilization_id_fkey FOREIGN KEY (civilization_id) REFERENCES public.civilizations(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- Name: npc_interaction_rule rule_npc_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.npc_interaction_rule
    ADD CONSTRAINT rule_npc_fkey FOREIGN KEY (npc_id) REFERENCES public.npc(npc_id) ON DELETE CASCADE;


--
-- Name: skill_discovery_rule skill_discovery_rule_skill_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.skill_discovery_rule
    ADD CONSTRAINT skill_discovery_rule_skill_id_fkey FOREIGN KEY (skill_id) REFERENCES public.skill(skill_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: npc_merchant_stock stock_item_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.npc_merchant_stock
    ADD CONSTRAINT stock_item_fkey FOREIGN KEY (item_id) REFERENCES public.item(item_id) ON DELETE CASCADE;


--
-- Name: npc_merchant_stock stock_npc_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.npc_merchant_stock
    ADD CONSTRAINT stock_npc_fkey FOREIGN KEY (npc_id) REFERENCES public.npc(npc_id) ON DELETE CASCADE;


--
-- Name: world_links world_links_source_location_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.world_links
    ADD CONSTRAINT world_links_source_location_id_fkey FOREIGN KEY (source_location_id) REFERENCES public.location(location_id) ON DELETE CASCADE;


--
-- Name: world_links world_links_target_location_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.world_links
    ADD CONSTRAINT world_links_target_location_id_fkey FOREIGN KEY (target_location_id) REFERENCES public.location(location_id) ON DELETE CASCADE;


--
-- Name: world_objects world_objects_location_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.world_objects
    ADD CONSTRAINT world_objects_location_id_fkey FOREIGN KEY (location_id) REFERENCES public.location(location_id) ON DELETE CASCADE;


--
-- Name: world_rules world_rules_affected_civilization_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.world_rules
    ADD CONSTRAINT world_rules_affected_civilization_id_fkey FOREIGN KEY (affected_civilization_id) REFERENCES public.civilizations(id);


--
-- Name: world_rules world_rules_affected_location_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.world_rules
    ADD CONSTRAINT world_rules_affected_location_id_fkey FOREIGN KEY (affected_location_id) REFERENCES public.location(location_id);


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;


--
-- PostgreSQL database dump complete
--

\unrestrict VBp4MP2UHmlxVwpAWDCa3Zpbgea8m5MJPvA3I5guT7wQhNXQwbz1OKsDxNrplaS

