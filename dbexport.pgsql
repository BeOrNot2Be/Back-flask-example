
--
-- PostgreSQL database dump
--

-- Dumped from database version 10.5
-- Dumped by pg_dump version 10.5

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: against_discussion; Type: TABLE; Schema: public; Owner: nauma
--

CREATE TABLE public.against_discussion (
    user_id integer,
    discussion_id integer
);


ALTER TABLE public.against_discussion OWNER TO nauma;

--
-- Name: alerts; Type: TABLE; Schema: public; Owner: nauma
--

CREATE TABLE public.alerts (
    disscution_id integer,
    description text
);


ALTER TABLE public.alerts OWNER TO nauma;

--
-- Name: argument_comments; Type: TABLE; Schema: public; Owner: nauma
--

CREATE TABLE public.argument_comments (
    id integer NOT NULL,
    argument_id integer NOT NULL,
    reply_id integer,
    "position" integer NOT NULL,
    description character varying(255) NOT NULL,
    links text,
    files text,
    date character varying(100) NOT NULL,
    score double precision
);


ALTER TABLE public.argument_comments OWNER TO nauma;

--
-- Name: argument_comments_id_seq; Type: SEQUENCE; Schema: public; Owner: nauma
--

CREATE SEQUENCE public.argument_comments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.argument_comments_id_seq OWNER TO nauma;

--
-- Name: argument_comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nauma
--

ALTER SEQUENCE public.argument_comments_id_seq OWNED BY public.argument_comments.id;


--
-- Name: aspects; Type: TABLE; Schema: public; Owner: nauma
--

CREATE TABLE public.aspects (
    id integer NOT NULL,
    title character varying(50) NOT NULL,
    image character varying(100) NOT NULL,
    init integer DEFAULT 0
);


ALTER TABLE public.aspects OWNER TO nauma;

--
-- Name: aspects_id_seq; Type: SEQUENCE; Schema: public; Owner: nauma
--

CREATE SEQUENCE public.aspects_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.aspects_id_seq OWNER TO nauma;

--
-- Name: aspects_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nauma
--

ALTER SEQUENCE public.aspects_id_seq OWNED BY public.aspects.id;


--
-- Name: claims; Type: TABLE; Schema: public; Owner: nauma
--

CREATE TABLE public.claims (
    id integer NOT NULL,
    author text,
    tesis_id text,
    title text,
    description text
);


ALTER TABLE public.claims OWNER TO nauma;

--
-- Name: comments_liked; Type: TABLE; Schema: public; Owner: nauma
--

CREATE TABLE public.comments_liked (
    id integer NOT NULL,
    user_id integer,
    like_comment_id integer
);


ALTER TABLE public.comments_liked OWNER TO nauma;

--
-- Name: comments_liked_id_seq; Type: SEQUENCE; Schema: public; Owner: nauma
--

CREATE SEQUENCE public.comments_liked_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.comments_liked_id_seq OWNER TO nauma;

--
-- Name: comments_liked_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nauma
--

ALTER SEQUENCE public.comments_liked_id_seq OWNED BY public.comments_liked.id;


--
-- Name: discussion_arguments; Type: TABLE; Schema: public; Owner: nauma
--

CREATE TABLE public.discussion_arguments (
    id integer NOT NULL,
    discussion_id integer NOT NULL,
    aspect_id integer NOT NULL,
    "position" smallint NOT NULL,
    description text NOT NULL,
    links text,
    files text,
    date character varying(20),
    score integer
);


ALTER TABLE public.discussion_arguments OWNER TO nauma;

--
-- Name: discussion_arguments_id_seq; Type: SEQUENCE; Schema: public; Owner: nauma
--

CREATE SEQUENCE public.discussion_arguments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.discussion_arguments_id_seq OWNER TO nauma;

--
-- Name: discussion_arguments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nauma
--

ALTER SEQUENCE public.discussion_arguments_id_seq OWNED BY public.discussion_arguments.id;


--
-- Name: discussion_aspects; Type: TABLE; Schema: public; Owner: nauma
--

CREATE TABLE public.discussion_aspects (
    id integer NOT NULL,
    discussion_id integer NOT NULL,
    aspect_id integer NOT NULL
);


ALTER TABLE public.discussion_aspects OWNER TO nauma;

--
-- Name: discussion_aspects_id_seq; Type: SEQUENCE; Schema: public; Owner: nauma
--

CREATE SEQUENCE public.discussion_aspects_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.discussion_aspects_id_seq OWNER TO nauma;

--
-- Name: discussion_aspects_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nauma
--

ALTER SEQUENCE public.discussion_aspects_id_seq OWNED BY public.discussion_aspects.id;


--
-- Name: discussions; Type: TABLE; Schema: public; Owner: nauma
--

CREATE TABLE public.discussions (
    id integer NOT NULL,
    title character varying(100) NOT NULL,
    image character varying(100) NOT NULL,
    author integer,
    scores double precision
);


ALTER TABLE public.discussions OWNER TO nauma;

--
-- Name: discussions_id_seq; Type: SEQUENCE; Schema: public; Owner: nauma
--

CREATE SEQUENCE public.discussions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.discussions_id_seq OWNER TO nauma;

--
-- Name: discussions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nauma
--

ALTER SEQUENCE public.discussions_id_seq OWNED BY public.discussions.id;


--
-- Name: education_verifications; Type: TABLE; Schema: public; Owner: nauma
--

CREATE TABLE public.education_verifications (
    id integer NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.education_verifications OWNER TO nauma;

--
-- Name: education_verifications_id_seq; Type: SEQUENCE; Schema: public; Owner: nauma
--

CREATE SEQUENCE public.education_verifications_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.education_verifications_id_seq OWNER TO nauma;

--
-- Name: education_verifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nauma
--

ALTER SEQUENCE public.education_verifications_id_seq OWNED BY public.education_verifications.id;


--
-- Name: educations; Type: TABLE; Schema: public; Owner: nauma
--

CREATE TABLE public.educations (
    id integer NOT NULL,
    user_id integer NOT NULL,
    country character varying(50) NOT NULL,
    city character varying(50) NOT NULL,
    hight_school character varying(50) NOT NULL,
    faculty character varying(100) NOT NULL,
    specialty character varying(100) NOT NULL,
    date character varying(20) NOT NULL,
    scan character varying(100) NOT NULL,
    verification boolean DEFAULT false
);


ALTER TABLE public.educations OWNER TO nauma;

--
-- Name: educations_id_seq; Type: SEQUENCE; Schema: public; Owner: nauma
--

CREATE SEQUENCE public.educations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.educations_id_seq OWNER TO nauma;

--
-- Name: educations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nauma
--

ALTER SEQUENCE public.educations_id_seq OWNED BY public.educations.id;


--
-- Name: favorite_aspects; Type: TABLE; Schema: public; Owner: nauma
--

CREATE TABLE public.favorite_aspects (
    id integer NOT NULL,
    user_id integer NOT NULL,
    aspect_id integer NOT NULL,
    date character varying(50) NOT NULL
);


ALTER TABLE public.favorite_aspects OWNER TO nauma;

--
-- Name: favorite_aspects_id_seq; Type: SEQUENCE; Schema: public; Owner: nauma
--

CREATE SEQUENCE public.favorite_aspects_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.favorite_aspects_id_seq OWNER TO nauma;

--
-- Name: favorite_aspects_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nauma
--

ALTER SEQUENCE public.favorite_aspects_id_seq OWNED BY public.favorite_aspects.id;


--
-- Name: favorite_disquss; Type: TABLE; Schema: public; Owner: nauma
--

CREATE TABLE public.favorite_disquss (
    id integer NOT NULL,
    user_id integer NOT NULL,
    disquss_id integer NOT NULL,
    date character varying(50)
);


ALTER TABLE public.favorite_disquss OWNER TO nauma;

--
-- Name: favorite_disquss_id_seq; Type: SEQUENCE; Schema: public; Owner: nauma
--

CREATE SEQUENCE public.favorite_disquss_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.favorite_disquss_id_seq OWNER TO nauma;

--
-- Name: favorite_disquss_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nauma
--

ALTER SEQUENCE public.favorite_disquss_id_seq OWNED BY public.favorite_disquss.id;


--
-- Name: favorite_users; Type: TABLE; Schema: public; Owner: nauma
--

CREATE TABLE public.favorite_users (
    id integer NOT NULL,
    author_id integer NOT NULL,
    user_id integer NOT NULL,
    date character varying(50) NOT NULL
);


ALTER TABLE public.favorite_users OWNER TO nauma;

--
-- Name: favorite_users_id_seq; Type: SEQUENCE; Schema: public; Owner: nauma
--

CREATE SEQUENCE public.favorite_users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.favorite_users_id_seq OWNER TO nauma;

--
-- Name: favorite_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nauma
--

ALTER SEQUENCE public.favorite_users_id_seq OWNED BY public.favorite_users.id;


--
-- Name: feedback; Type: TABLE; Schema: public; Owner: nauma
--

CREATE TABLE public.feedback (
    id integer NOT NULL,
    fullname character varying(50) NOT NULL,
    email character varying(100) NOT NULL,
    theme character varying(100) NOT NULL,
    message character varying(255) NOT NULL,
    file character varying(50)
);


ALTER TABLE public.feedback OWNER TO nauma;

--
-- Name: feedback_id_seq; Type: SEQUENCE; Schema: public; Owner: nauma
--

CREATE SEQUENCE public.feedback_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.feedback_id_seq OWNER TO nauma;

--
-- Name: feedback_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nauma
--

ALTER SEQUENCE public.feedback_id_seq OWNED BY public.feedback.id;


--
-- Name: fludding; Type: TABLE; Schema: public; Owner: nauma
--

CREATE TABLE public.fludding (
    uid integer,
    date timestamp without time zone
);


ALTER TABLE public.fludding OWNER TO nauma;

--
-- Name: for_discussion; Type: TABLE; Schema: public; Owner: nauma
--

CREATE TABLE public.for_discussion (
    user_id integer,
    discussion_id integer
);


ALTER TABLE public.for_discussion OWNER TO nauma;

--
-- Name: gen_data; Type: TABLE; Schema: public; Owner: nauma
--

CREATE TABLE public.gen_data (
    country text,
    against integer,
    forr integer,
    year integer
);


ALTER TABLE public.gen_data OWNER TO nauma;

--
-- Name: knowledges; Type: TABLE; Schema: public; Owner: nauma
--

CREATE TABLE public.knowledges (
    id integer NOT NULL,
    title character varying(50) NOT NULL,
    image character varying(100) NOT NULL
);


ALTER TABLE public.knowledges OWNER TO nauma;

--
-- Name: knowledges_id_seq; Type: SEQUENCE; Schema: public; Owner: nauma
--

CREATE SEQUENCE public.knowledges_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.knowledges_id_seq OWNER TO nauma;

--
-- Name: knowledges_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nauma
--

ALTER SEQUENCE public.knowledges_id_seq OWNED BY public.knowledges.id;


--
-- Name: mute; Type: TABLE; Schema: public; Owner: nauma
--

CREATE TABLE public.mute (
    mark boolean,
    comment boolean,
    id integer
);


ALTER TABLE public.mute OWNER TO nauma;

--
-- Name: rewards; Type: TABLE; Schema: public; Owner: nauma
--

CREATE TABLE public.rewards (
    id integer NOT NULL,
    title character varying(50) NOT NULL,
    description character varying(200) NOT NULL,
    image character varying(100) NOT NULL
);


ALTER TABLE public.rewards OWNER TO nauma;

--
-- Name: rewards_id_seq; Type: SEQUENCE; Schema: public; Owner: nauma
--

CREATE SEQUENCE public.rewards_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.rewards_id_seq OWNER TO nauma;

--
-- Name: rewards_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nauma
--

ALTER SEQUENCE public.rewards_id_seq OWNED BY public.rewards.id;


--
-- Name: user_knowledges; Type: TABLE; Schema: public; Owner: nauma
--

CREATE TABLE public.user_knowledges (
    id integer NOT NULL,
    user_id integer NOT NULL,
    knowledge_id integer NOT NULL,
    score integer NOT NULL
);


ALTER TABLE public.user_knowledges OWNER TO nauma;

--
-- Name: user_knowledge_id_seq; Type: SEQUENCE; Schema: public; Owner: nauma
--

CREATE SEQUENCE public.user_knowledge_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_knowledge_id_seq OWNER TO nauma;

--
-- Name: user_knowledge_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nauma
--

ALTER SEQUENCE public.user_knowledge_id_seq OWNED BY public.user_knowledges.id;


--
-- Name: user_liked; Type: TABLE; Schema: public; Owner: nauma
--

CREATE TABLE public.user_liked (
    id integer NOT NULL,
    user_id integer,
    like_user_id integer
);


ALTER TABLE public.user_liked OWNER TO nauma;

--
-- Name: user_liked_id_seq; Type: SEQUENCE; Schema: public; Owner: nauma
--

CREATE SEQUENCE public.user_liked_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_liked_id_seq OWNER TO nauma;

--
-- Name: user_liked_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nauma
--

ALTER SEQUENCE public.user_liked_id_seq OWNED BY public.user_liked.id;


--
-- Name: user_rewards; Type: TABLE; Schema: public; Owner: nauma
--

CREATE TABLE public.user_rewards (
    id integer NOT NULL,
    user_id integer NOT NULL,
    reward_id integer NOT NULL,
    date character varying(50)
);


ALTER TABLE public.user_rewards OWNER TO nauma;

--
-- Name: user_rewards_id_seq; Type: SEQUENCE; Schema: public; Owner: nauma
--

CREATE SEQUENCE public.user_rewards_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_rewards_id_seq OWNER TO nauma;

--
-- Name: user_rewards_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nauma
--

ALTER SEQUENCE public.user_rewards_id_seq OWNED BY public.user_rewards.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: nauma
--

CREATE TABLE public.users (
    id integer NOT NULL,
    fullname character varying(50) NOT NULL,
    email character varying(70) NOT NULL,
    password character varying(70) NOT NULL,
    avatar character varying(100) DEFAULT 'avatar.jpg'::character varying,
    token character varying(100) NOT NULL
);


ALTER TABLE public.users OWNER TO nauma;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: nauma
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO nauma;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nauma
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: verefication; Type: TABLE; Schema: public; Owner: nauma
--

CREATE TABLE public.verefication (
    verefizied boolean,
    id integer
);


ALTER TABLE public.verefication OWNER TO nauma;

--
-- Name: argument_comments id; Type: DEFAULT; Schema: public; Owner: nauma
--

ALTER TABLE ONLY public.argument_comments ALTER COLUMN id SET DEFAULT nextval('public.argument_comments_id_seq'::regclass);


--
-- Name: aspects id; Type: DEFAULT; Schema: public; Owner: nauma
--

ALTER TABLE ONLY public.aspects ALTER COLUMN id SET DEFAULT nextval('public.aspects_id_seq'::regclass);


--
-- Name: comments_liked id; Type: DEFAULT; Schema: public; Owner: nauma
--

ALTER TABLE ONLY public.comments_liked ALTER COLUMN id SET DEFAULT nextval('public.comments_liked_id_seq'::regclass);


--
-- Name: discussion_arguments id; Type: DEFAULT; Schema: public; Owner: nauma
--

ALTER TABLE ONLY public.discussion_arguments ALTER COLUMN id SET DEFAULT nextval('public.discussion_arguments_id_seq'::regclass);


--
-- Name: discussion_aspects id; Type: DEFAULT; Schema: public; Owner: nauma
--

ALTER TABLE ONLY public.discussion_aspects ALTER COLUMN id SET DEFAULT nextval('public.discussion_aspects_id_seq'::regclass);


--
-- Name: discussions id; Type: DEFAULT; Schema: public; Owner: nauma
--

ALTER TABLE ONLY public.discussions ALTER COLUMN id SET DEFAULT nextval('public.discussions_id_seq'::regclass);


--
-- Name: education_verifications id; Type: DEFAULT; Schema: public; Owner: nauma
--

ALTER TABLE ONLY public.education_verifications ALTER COLUMN id SET DEFAULT nextval('public.education_verifications_id_seq'::regclass);


--
-- Name: educations id; Type: DEFAULT; Schema: public; Owner: nauma
--

ALTER TABLE ONLY public.educations ALTER COLUMN id SET DEFAULT nextval('public.educations_id_seq'::regclass);


--
-- Name: favorite_aspects id; Type: DEFAULT; Schema: public; Owner: nauma
--

ALTER TABLE ONLY public.favorite_aspects ALTER COLUMN id SET DEFAULT nextval('public.favorite_aspects_id_seq'::regclass);


--
-- Name: favorite_disquss id; Type: DEFAULT; Schema: public; Owner: nauma
--

ALTER TABLE ONLY public.favorite_disquss ALTER COLUMN id SET DEFAULT nextval('public.favorite_disquss_id_seq'::regclass);


--
-- Name: favorite_users id; Type: DEFAULT; Schema: public; Owner: nauma
--

ALTER TABLE ONLY public.favorite_users ALTER COLUMN id SET DEFAULT nextval('public.favorite_users_id_seq'::regclass);


--
-- Name: feedback id; Type: DEFAULT; Schema: public; Owner: nauma
--

ALTER TABLE ONLY public.feedback ALTER COLUMN id SET DEFAULT nextval('public.feedback_id_seq'::regclass);


--
-- Name: knowledges id; Type: DEFAULT; Schema: public; Owner: nauma
--

ALTER TABLE ONLY public.knowledges ALTER COLUMN id SET DEFAULT nextval('public.knowledges_id_seq'::regclass);


--
-- Name: rewards id; Type: DEFAULT; Schema: public; Owner: nauma
--

ALTER TABLE ONLY public.rewards ALTER COLUMN id SET DEFAULT nextval('public.rewards_id_seq'::regclass);


--
-- Name: user_knowledges id; Type: DEFAULT; Schema: public; Owner: nauma
--

ALTER TABLE ONLY public.user_knowledges ALTER COLUMN id SET DEFAULT nextval('public.user_knowledge_id_seq'::regclass);


--
-- Name: user_liked id; Type: DEFAULT; Schema: public; Owner: nauma
--

ALTER TABLE ONLY public.user_liked ALTER COLUMN id SET DEFAULT nextval('public.user_liked_id_seq'::regclass);


--
-- Name: user_rewards id; Type: DEFAULT; Schema: public; Owner: nauma
--

ALTER TABLE ONLY public.user_rewards ALTER COLUMN id SET DEFAULT nextval('public.user_rewards_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: nauma
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: against_discussion; Type: TABLE DATA; Schema: public; Owner: nauma
--

COPY public.against_discussion (user_id, discussion_id) FROM stdin;
\.


--
-- Data for Name: alerts; Type: TABLE DATA; Schema: public; Owner: nauma
--

COPY public.alerts (disscution_id, description) FROM stdin;
\.


--
-- Data for Name: argument_comments; Type: TABLE DATA; Schema: public; Owner: nauma
--

COPY public.argument_comments (id, argument_id, reply_id, "position", description, links, files, date, score) FROM stdin;
\.


--
-- Data for Name: aspects; Type: TABLE DATA; Schema: public; Owner: nauma
--

COPY public.aspects (id, title, image, init) FROM stdin;
1	Aspect 1	default.jpg	1
2	Aspect 2	history.png	1
3	Aspect 3	space.png	1
4	Aspect 4	physics.jpg	1
\.


--
-- Data for Name: claims; Type: TABLE DATA; Schema: public; Owner: nauma
--

COPY public.claims (id, author, tesis_id, title, description) FROM stdin;
\.


--
-- Data for Name: comments_liked; Type: TABLE DATA; Schema: public; Owner: nauma
--

COPY public.comments_liked (id, user_id, like_comment_id) FROM stdin;
\.


--
-- Data for Name: discussion_arguments; Type: TABLE DATA; Schema: public; Owner: nauma
--

COPY public.discussion_arguments (id, discussion_id, aspect_id, "position", description, links, files, date, score) FROM stdin;
9	32	1	1	This is dest description	["link1", "link2"]	[]	\N	\N
10	33	2	1	sdfsfsfsdf	["sdfsdfsdf", "dsfsdfsdf"]	["IMG_0550.JPG", "IMG_0551.JPG"]	\N	\N
11	35	2	1	sdfsfsfsdf	["sdfsdfsdf", "dsfsdfsdf"]	["IMG_0550.JPG", "IMG_0551.JPG"]	\N	\N
\.


--
-- Data for Name: discussion_aspects; Type: TABLE DATA; Schema: public; Owner: nauma
--

COPY public.discussion_aspects (id, discussion_id, aspect_id) FROM stdin;
1	32	1
2	33	2
3	33	2
4	35	2
\.


--
-- Data for Name: discussions; Type: TABLE DATA; Schema: public; Owner: nauma
--

COPY public.discussions (id, title, image, author, scores) FROM stdin;
\.


--
-- Data for Name: education_verifications; Type: TABLE DATA; Schema: public; Owner: nauma
--

COPY public.education_verifications (id, user_id) FROM stdin;
1	6
\.


--
-- Data for Name: educations; Type: TABLE DATA; Schema: public; Owner: nauma
--

COPY public.educations (id, user_id, country, city, hight_school, faculty, specialty, date, scan, verification) FROM stdin;
\.


--
-- Data for Name: favorite_aspects; Type: TABLE DATA; Schema: public; Owner: nauma
--

COPY public.favorite_aspects (id, user_id, aspect_id, date) FROM stdin;
\.


--
-- Data for Name: favorite_disquss; Type: TABLE DATA; Schema: public; Owner: nauma
--

COPY public.favorite_disquss (id, user_id, disquss_id, date) FROM stdin;
\.


--
-- Data for Name: favorite_users; Type: TABLE DATA; Schema: public; Owner: nauma
--

COPY public.favorite_users (id, author_id, user_id, date) FROM stdin;
\.


--
-- Data for Name: feedback; Type: TABLE DATA; Schema: public; Owner: nauma
--

COPY public.feedback (id, fullname, email, theme, message, file) FROM stdin;
\.


--
-- Data for Name: fludding; Type: TABLE DATA; Schema: public; Owner: nauma
--

COPY public.fludding (uid, date) FROM stdin;
\.


--
-- Data for Name: for_discussion; Type: TABLE DATA; Schema: public; Owner: nauma
--

COPY public.for_discussion (user_id, discussion_id) FROM stdin;
\.


--
-- Data for Name: gen_data; Type: TABLE DATA; Schema: public; Owner: nauma
--

COPY public.gen_data (country, against, forr, year) FROM stdin;
\.


--
-- Data for Name: knowledges; Type: TABLE DATA; Schema: public; Owner: nauma
--

COPY public.knowledges (id, title, image) FROM stdin;
1	Test 1	knowledge.png
2	Basic	knowledge.png
3	Really	knowledge.png
\.


--
-- Data for Name: mute; Type: TABLE DATA; Schema: public; Owner: nauma
--

COPY public.mute (mark, comment, id) FROM stdin;
\.


--
-- Data for Name: rewards; Type: TABLE DATA; Schema: public; Owner: nauma
--

COPY public.rewards (id, title, description, image) FROM stdin;
1	В игре	За регистрация на сайте	reward.png
\.


--
-- Data for Name: user_knowledges; Type: TABLE DATA; Schema: public; Owner: nauma
--

COPY public.user_knowledges (id, user_id, knowledge_id, score) FROM stdin;
\.


--
-- Data for Name: user_liked; Type: TABLE DATA; Schema: public; Owner: nauma
--

COPY public.user_liked (id, user_id, like_user_id) FROM stdin;
\.


--
-- Data for Name: user_rewards; Type: TABLE DATA; Schema: public; Owner: nauma
--

COPY public.user_rewards (id, user_id, reward_id, date) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: nauma
--

COPY public.users (id, fullname, email, password, avatar, token) FROM stdin;
\.


--
-- Data for Name: verefication; Type: TABLE DATA; Schema: public; Owner: nauma
--

COPY public.verefication (verefizied, id) FROM stdin;
\.


--
-- Name: argument_comments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nauma
--

SELECT pg_catalog.setval('public.argument_comments_id_seq', 1, false);


--
-- Name: aspects_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nauma
--

SELECT pg_catalog.setval('public.aspects_id_seq', 4, true);


--
-- Name: comments_liked_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nauma
--

SELECT pg_catalog.setval('public.comments_liked_id_seq', 1, false);


--
-- Name: discussion_arguments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nauma
--

SELECT pg_catalog.setval('public.discussion_arguments_id_seq', 11, true);


--
-- Name: discussion_aspects_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nauma
--

SELECT pg_catalog.setval('public.discussion_aspects_id_seq', 4, true);


--
-- Name: discussions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nauma
--

SELECT pg_catalog.setval('public.discussions_id_seq', 1, false);


--
-- Name: education_verifications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nauma
--

SELECT pg_catalog.setval('public.education_verifications_id_seq', 20, true);


--
-- Name: educations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nauma
--

SELECT pg_catalog.setval('public.educations_id_seq', 1, false);


--
-- Name: favorite_aspects_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nauma
--

SELECT pg_catalog.setval('public.favorite_aspects_id_seq', 1, false);


--
-- Name: favorite_disquss_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nauma
--

SELECT pg_catalog.setval('public.favorite_disquss_id_seq', 1, false);


--
-- Name: favorite_users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nauma
--

SELECT pg_catalog.setval('public.favorite_users_id_seq', 1, false);


--
-- Name: feedback_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nauma
--

SELECT pg_catalog.setval('public.feedback_id_seq', 1, false);


--
-- Name: knowledges_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nauma
--

SELECT pg_catalog.setval('public.knowledges_id_seq', 3, true);


--
-- Name: rewards_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nauma
--

SELECT pg_catalog.setval('public.rewards_id_seq', 1, true);


--
-- Name: user_knowledge_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nauma
--

SELECT pg_catalog.setval('public.user_knowledge_id_seq', 12, true);


--
-- Name: user_liked_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nauma
--

SELECT pg_catalog.setval('public.user_liked_id_seq', 1, false);


--
-- Name: user_rewards_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nauma
--

SELECT pg_catalog.setval('public.user_rewards_id_seq', 1, false);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nauma
--

SELECT pg_catalog.setval('public.users_id_seq', 1, false);


--
-- Name: argument_comments argument_comments_pkey; Type: CONSTRAINT; Schema: public; Owner: nauma
--

ALTER TABLE ONLY public.argument_comments
    ADD CONSTRAINT argument_comments_pkey PRIMARY KEY (id);


--
-- Name: aspects aspects_pkey; Type: CONSTRAINT; Schema: public; Owner: nauma
--

ALTER TABLE ONLY public.aspects
    ADD CONSTRAINT aspects_pkey PRIMARY KEY (id);


--
-- Name: claims claims_pkey; Type: CONSTRAINT; Schema: public; Owner: nauma
--

ALTER TABLE ONLY public.claims
    ADD CONSTRAINT claims_pkey PRIMARY KEY (id);


--
-- Name: comments_liked comments_liked_pkey; Type: CONSTRAINT; Schema: public; Owner: nauma
--

ALTER TABLE ONLY public.comments_liked
    ADD CONSTRAINT comments_liked_pkey PRIMARY KEY (id);


--
-- Name: discussion_arguments discussion_arguments_pkey; Type: CONSTRAINT; Schema: public; Owner: nauma
--

ALTER TABLE ONLY public.discussion_arguments
    ADD CONSTRAINT discussion_arguments_pkey PRIMARY KEY (id);


--
-- Name: discussion_aspects discussion_aspects_pkey; Type: CONSTRAINT; Schema: public; Owner: nauma
--

ALTER TABLE ONLY public.discussion_aspects
    ADD CONSTRAINT discussion_aspects_pkey PRIMARY KEY (id);


--
-- Name: discussions discussions_pkey; Type: CONSTRAINT; Schema: public; Owner: nauma
--

ALTER TABLE ONLY public.discussions
    ADD CONSTRAINT discussions_pkey PRIMARY KEY (id);


--
-- Name: education_verifications education_verifications_pkey; Type: CONSTRAINT; Schema: public; Owner: nauma
--

ALTER TABLE ONLY public.education_verifications
    ADD CONSTRAINT education_verifications_pkey PRIMARY KEY (id);


--
-- Name: education_verifications education_verifications_user_id_key; Type: CONSTRAINT; Schema: public; Owner: nauma
--

ALTER TABLE ONLY public.education_verifications
    ADD CONSTRAINT education_verifications_user_id_key UNIQUE (user_id);


--
-- Name: educations educations_pkey; Type: CONSTRAINT; Schema: public; Owner: nauma
--

ALTER TABLE ONLY public.educations
    ADD CONSTRAINT educations_pkey PRIMARY KEY (id);


--
-- Name: favorite_aspects favorite_aspects_pkey; Type: CONSTRAINT; Schema: public; Owner: nauma
--

ALTER TABLE ONLY public.favorite_aspects
    ADD CONSTRAINT favorite_aspects_pkey PRIMARY KEY (id);


--
-- Name: favorite_disquss favorite_disquss_pkey; Type: CONSTRAINT; Schema: public; Owner: nauma
--

ALTER TABLE ONLY public.favorite_disquss
    ADD CONSTRAINT favorite_disquss_pkey PRIMARY KEY (id);


--
-- Name: favorite_users favorite_users_pkey; Type: CONSTRAINT; Schema: public; Owner: nauma
--

ALTER TABLE ONLY public.favorite_users
    ADD CONSTRAINT favorite_users_pkey PRIMARY KEY (id);


--
-- Name: feedback feedback_pkey; Type: CONSTRAINT; Schema: public; Owner: nauma
--

ALTER TABLE ONLY public.feedback
    ADD CONSTRAINT feedback_pkey PRIMARY KEY (id);


--
-- Name: knowledges knowledges_pkey; Type: CONSTRAINT; Schema: public; Owner: nauma
--

ALTER TABLE ONLY public.knowledges
    ADD CONSTRAINT knowledges_pkey PRIMARY KEY (id);


--
-- Name: rewards rewards_pkey; Type: CONSTRAINT; Schema: public; Owner: nauma
--

ALTER TABLE ONLY public.rewards
    ADD CONSTRAINT rewards_pkey PRIMARY KEY (id);


--
-- Name: user_knowledges user_knowledge_pkey; Type: CONSTRAINT; Schema: public; Owner: nauma
--

ALTER TABLE ONLY public.user_knowledges
    ADD CONSTRAINT user_knowledge_pkey PRIMARY KEY (id);


--
-- Name: user_liked user_liked_pkey; Type: CONSTRAINT; Schema: public; Owner: nauma
--

ALTER TABLE ONLY public.user_liked
    ADD CONSTRAINT user_liked_pkey PRIMARY KEY (id);


--
-- Name: user_rewards user_rewards_pkey; Type: CONSTRAINT; Schema: public; Owner: nauma
--

ALTER TABLE ONLY public.user_rewards
    ADD CONSTRAINT user_rewards_pkey PRIMARY KEY (id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: nauma
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: nauma
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: educations educations_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: nauma
--

ALTER TABLE ONLY public.educations
    ADD CONSTRAINT educations_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- PostgreSQL database dump complete
--

