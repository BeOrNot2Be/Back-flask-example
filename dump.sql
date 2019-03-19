--
-- PostgreSQL database dump
--

-- Dumped from database version 11.1
-- Dumped by pg_dump version 11.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

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
-- Name: claims; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.claims (
    id integer NOT NULL,
    author integer,
    tesis_id integer,
    title text,
    description text
);


ALTER TABLE public.claims OWNER TO postgres;

--
-- Name: claims_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.claims_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.claims_id_seq OWNER TO postgres;

--
-- Name: claims_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.claims_id_seq OWNED BY public.claims.id;


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
    score integer,
    date timestamp without time zone
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
-- Name: claims id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.claims ALTER COLUMN id SET DEFAULT nextval('public.claims_id_seq'::regclass);


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
1	not something
\.


--
-- Data for Name: argument_comments; Type: TABLE DATA; Schema: public; Owner: nauma
--

COPY public.argument_comments (id, argument_id, reply_id, "position", description, links, files, date, score) FROM stdin;
1	1	1	1	ko	p3pc	fevef	2019-02-08 22:42:49.546908-08	699
2	1	1	1	smth	""	[]	2019-02-09 19:13:20.908159-08	0
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
-- Data for Name: claims; Type: TABLE DATA; Schema: public; Owner: postgres
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

COPY public.discussion_arguments (id, discussion_id, aspect_id, "position", description, links, files, score, date) FROM stdin;
9	32	1	1	This is dest description	["link1", "link2"]	[]	\N	2019-02-08 23:08:40.744458
10	33	2	1	sdfsfsfsdf	["sdfsdfsdf", "dsfsdfsdf"]	["IMG_0550.JPG", "IMG_0551.JPG"]	\N	2019-02-08 23:08:40.744458
11	35	2	1	sdfsfsfsdf	["sdfsdfsdf", "dsfsdfsdf"]	["IMG_0550.JPG", "IMG_0551.JPG"]	\N	2019-02-08 23:08:40.744458
1	33	1	1	d,e,cpfe,,efv	["link1"]	[]	500	2019-02-08 23:08:40.744458
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
2	random_name	http:/google.com/favicon.icon	2	36610
3	random_name	http:/google.com/favicon.icon	3	79250
4	random_name	http:/google.com/favicon.icon	4	12630
5	random_name	http:/google.com/favicon.icon	5	40581
6	random_name	http:/google.com/favicon.icon	6	88728
7	random_name	http:/google.com/favicon.icon	7	65177
8	random_name	http:/google.com/favicon.icon	8	72242
9	random_name	http:/google.com/favicon.icon	9	80652
10	random_name	http:/google.com/favicon.icon	1	94910
11	random_name	http:/google.com/favicon.icon	2	42362
12	random_name	http:/google.com/favicon.icon	3	24242
13	random_name	http:/google.com/favicon.icon	4	86571
14	random_name	http:/google.com/favicon.icon	5	72323
15	random_name	http:/google.com/favicon.icon	6	25333
16	random_name	http:/google.com/favicon.icon	7	47100
17	random_name	http:/google.com/favicon.icon	8	8655
18	random_name	http:/google.com/favicon.icon	9	36562
19	random_name	http:/google.com/favicon.icon	10	50054
20	random_name	http:/google.com/favicon.icon	1	80583
21	random_name	http:/google.com/favicon.icon	2	89345
22	random_name	http:/google.com/favicon.icon	3	75392
23	random_name	http:/google.com/favicon.icon	4	44751
24	random_name	http:/google.com/favicon.icon	5	51367
25	random_name	http:/google.com/favicon.icon	6	41300
26	random_name	http:/google.com/favicon.icon	7	15230
27	random_name	http:/google.com/favicon.icon	8	30372
28	random_name	http:/google.com/favicon.icon	9	10684
29	random_name	http:/google.com/favicon.icon	10	79507
30	random_name	http:/google.com/favicon.icon	1	62193
31	random_name	http:/google.com/favicon.icon	2	29691
32	random_name	http:/google.com/favicon.icon	3	80918
34	random_name	http:/google.com/favicon.icon	5	40777
35	random_name	http:/google.com/favicon.icon	6	98741
36	random_name	http:/google.com/favicon.icon	7	9965
37	random_name	http:/google.com/favicon.icon	8	16129
38	random_name	http:/google.com/favicon.icon	9	56963
39	random_name	http:/google.com/favicon.icon	10	30699
1	random_name	http:/google.com/favicon.icon	1	20562.5
33	random_name	http:/google.com/favicon.icon	4	76990
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
1	1	uk	Grinvich	st.Vilyam	literature	writer	12.43.53		f
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
1	2019-02-09 01:25:53.107813
1	2019-02-09 01:26:11.702711
1	2019-02-09 19:11:32.943458
1	2019-02-09 19:13:20.883721
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
UK	243243	14431	2015
UK	2432	14466	2016
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
t	f	1
t	t	1
t	t	1
t	t	1
t	t	1
t	t	1
t	t	1
t	t	1
t	t	1
t	t	1
t	t	1
t	t	1
t	t	1
t	t	1
t	t	1
t	t	1
t	t	1
t	t	1
t	t	1
t	t	1
t	t	1
t	t	1
t	t	1
t	t	1
t	t	1
t	t	1
t	t	1
t	t	1
t	t	1
t	t	1
t	t	1
t	t	1
t	t	1
t	t	1
t	t	1
t	t	1
t	t	1
t	t	1
t	t	1
t	t	1
t	t	1
t	t	1
t	t	1
t	t	1
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
16	2	3
\.


--
-- Data for Name: user_rewards; Type: TABLE DATA; Schema: public; Owner: nauma
--

COPY public.user_rewards (id, user_id, reward_id, date) FROM stdin;
1	1	1	2019-02-07 00:58:52.447685-08
2	1	1	2019-02-07 19:38:07.215734-08
3	1	1	2019-02-07 19:48:32.254338-08
4	1	1	2019-02-07 19:49:06.115318-08
5	1	1	2019-02-07 19:49:51.248761-08
6	1	1	2019-02-07 20:07:03.406686-08
7	1	1	2019-02-07 20:49:57.5243-08
8	1	1	2019-02-07 20:52:25.578812-08
9	1	1	2019-02-07 20:53:44.075886-08
10	1	1	2019-02-07 21:18:13.564565-08
11	1	1	2019-02-07 21:19:50.639518-08
12	1	1	2019-02-07 21:20:32.900347-08
13	1	1	2019-02-07 21:51:55.15019-08
14	1	1	2019-02-07 22:00:59.136191-08
15	1	1	2019-02-07 22:09:00.444307-08
16	1	1	2019-02-07 22:10:50.792791-08
17	1	1	2019-02-07 22:19:19.817387-08
18	1	1	2019-02-07 22:29:37.206143-08
19	1	1	2019-02-07 22:29:42.032405-08
20	1	1	2019-02-07 22:31:10.706395-08
21	1	1	2019-02-07 22:31:40.833154-08
22	1	1	2019-02-07 22:31:51.691431-08
23	1	1	2019-02-07 22:32:22.445083-08
24	1	1	2019-02-07 22:32:28.616327-08
25	1	1	2019-02-07 22:34:02.185071-08
26	1	1	2019-02-07 22:35:02.244272-08
27	1	1	2019-02-07 22:35:42.342343-08
28	1	1	2019-02-07 22:49:33.032154-08
29	1	1	2019-02-08 21:02:18.409541-08
30	1	1	2019-02-08 21:20:49.503564-08
31	1	1	2019-02-08 21:21:19.037426-08
32	1	1	2019-02-08 21:21:38.424084-08
33	1	1	2019-02-08 21:22:26.328862-08
34	1	1	2019-02-08 21:22:51.242743-08
35	1	1	2019-02-08 23:14:53.138204-08
36	1	1	2019-02-08 23:16:05.566113-08
37	1	1	2019-02-08 23:16:12.922414-08
38	1	1	2019-02-08 23:18:23.118546-08
39	1	1	2019-02-08 23:20:41.132646-08
40	1	1	2019-02-08 23:21:53.218564-08
41	1	1	2019-02-09 00:12:08.306583-08
42	1	1	2019-02-09 00:15:01.378125-08
43	1	1	2019-02-09 00:17:03.384187-08
44	1	1	2019-02-09 00:18:18.915709-08
45	1	1	2019-02-09 00:19:19.023897-08
46	1	1	2019-02-09 00:20:49.542771-08
47	1	1	2019-02-09 00:21:40.485067-08
48	1	1	2019-02-09 00:21:52.057022-08
49	1	1	2019-02-09 00:39:55.7232-08
50	1	1	2019-02-09 01:04:40.509815-08
51	1	1	2019-02-09 01:25:04.353268-08
52	1	1	2019-02-09 19:11:32.053094-08
53	1	1	2019-02-09 19:13:20.522869-08
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: nauma
--

COPY public.users (id, fullname, email, password, avatar, token) FROM stdin;
1	bob solvie	32dwop@gmail.com	rvngrjlvgrg	vrgvrg	tokeen
2	random_name	ipman@gmail.com	1	http:/google.com/favicon.icon	70932
4	random_name	ipman@gmail.com1	1	http:/google.com/favicon.icon	11039
5	random_name	ipman@gmail.com2	2	http:/google.com/favicon.icon	76452
6	random_name	ipman@gmail.com3	3	http:/google.com/favicon.icon	25153
7	random_name	ipman@gmail.com4	4	http:/google.com/favicon.icon	83624
8	random_name	ipman@gmail.com5	5	http:/google.com/favicon.icon	40344
9	random_name	ipman@gmail.com6	6	http:/google.com/favicon.icon	85060
10	random_name	ipman@gmail.com7	7	http:/google.com/favicon.icon	41798
11	random_name	ipman@gmail.com8	8	http:/google.com/favicon.icon	94668
12	random_name	ipman@gmail.com9	9	http:/google.com/favicon.icon	28820
13	random_name	ipman@gmail.com10	10	http:/google.com/favicon.icon	47998
\.


--
-- Data for Name: verefication; Type: TABLE DATA; Schema: public; Owner: nauma
--

COPY public.verefication (verefizied, id) FROM stdin;
t	1
\.


--
-- Name: argument_comments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nauma
--

SELECT pg_catalog.setval('public.argument_comments_id_seq', 2, true);


--
-- Name: aspects_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nauma
--

SELECT pg_catalog.setval('public.aspects_id_seq', 4, true);


--
-- Name: claims_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.claims_id_seq', 40, true);


--
-- Name: comments_liked_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nauma
--

SELECT pg_catalog.setval('public.comments_liked_id_seq', 13, true);


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

SELECT pg_catalog.setval('public.discussions_id_seq', 39, true);


--
-- Name: education_verifications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nauma
--

SELECT pg_catalog.setval('public.education_verifications_id_seq', 20, true);


--
-- Name: educations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nauma
--

SELECT pg_catalog.setval('public.educations_id_seq', 1, true);


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

SELECT pg_catalog.setval('public.user_knowledge_id_seq', 270, true);


--
-- Name: user_liked_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nauma
--

SELECT pg_catalog.setval('public.user_liked_id_seq', 16, true);


--
-- Name: user_rewards_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nauma
--

SELECT pg_catalog.setval('public.user_rewards_id_seq', 53, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nauma
--

SELECT pg_catalog.setval('public.users_id_seq', 13, true);


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
-- Name: claims claims_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
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

