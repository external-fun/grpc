--
-- PostgreSQL database dump
--

-- Dumped from database version 15.2
-- Dumped by pg_dump version 15.2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: shop_db; Type: DATABASE; Schema: -; Owner: lispberry
--

CREATE DATABASE shop_db WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.UTF-8';


ALTER DATABASE shop_db OWNER TO lispberry;

\connect shop_db

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: public; Type: SCHEMA; Schema: -; Owner: lispberry
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO lispberry;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: Brand; Type: TABLE; Schema: public; Owner: lispberry
--

CREATE TABLE public."Brand" (
    id integer NOT NULL,
    name character varying NOT NULL
);


ALTER TABLE public."Brand" OWNER TO lispberry;

--
-- Name: Brand_id_seq; Type: SEQUENCE; Schema: public; Owner: lispberry
--

CREATE SEQUENCE public."Brand_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Brand_id_seq" OWNER TO lispberry;

--
-- Name: Brand_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lispberry
--

ALTER SEQUENCE public."Brand_id_seq" OWNED BY public."Brand".id;


--
-- Name: Category; Type: TABLE; Schema: public; Owner: lispberry
--

CREATE TABLE public."Category" (
    id integer NOT NULL,
    name character varying NOT NULL
);


ALTER TABLE public."Category" OWNER TO lispberry;

--
-- Name: Category_id_seq; Type: SEQUENCE; Schema: public; Owner: lispberry
--

CREATE SEQUENCE public."Category_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Category_id_seq" OWNER TO lispberry;

--
-- Name: Category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lispberry
--

ALTER SEQUENCE public."Category_id_seq" OWNED BY public."Category".id;


--
-- Name: Clothes; Type: TABLE; Schema: public; Owner: lispberry
--

CREATE TABLE public."Clothes" (
    id integer NOT NULL,
    name character varying,
    brand_id integer
);


ALTER TABLE public."Clothes" OWNER TO lispberry;

--
-- Name: ClothesAndCategory; Type: TABLE; Schema: public; Owner: lispberry
--

CREATE TABLE public."ClothesAndCategory" (
    clothes_id integer NOT NULL,
    category_id integer NOT NULL
);


ALTER TABLE public."ClothesAndCategory" OWNER TO lispberry;

--
-- Name: Clothes_id_seq; Type: SEQUENCE; Schema: public; Owner: lispberry
--

CREATE SEQUENCE public."Clothes_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Clothes_id_seq" OWNER TO lispberry;

--
-- Name: Clothes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lispberry
--

ALTER SEQUENCE public."Clothes_id_seq" OWNED BY public."Clothes".id;


--
-- Name: Record; Type: TABLE; Schema: public; Owner: lispberry
--

CREATE TABLE public."Record" (
    id integer NOT NULL,
    quantity integer NOT NULL,
    size_id integer NOT NULL,
    clothes_id integer NOT NULL
);


ALTER TABLE public."Record" OWNER TO lispberry;

--
-- Name: Record_id_seq; Type: SEQUENCE; Schema: public; Owner: lispberry
--

CREATE SEQUENCE public."Record_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Record_id_seq" OWNER TO lispberry;

--
-- Name: Record_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lispberry
--

ALTER SEQUENCE public."Record_id_seq" OWNED BY public."Record".id;


--
-- Name: Size; Type: TABLE; Schema: public; Owner: lispberry
--

CREATE TABLE public."Size" (
    id integer NOT NULL,
    name character varying
);


ALTER TABLE public."Size" OWNER TO lispberry;

--
-- Name: Size_id_seq; Type: SEQUENCE; Schema: public; Owner: lispberry
--

CREATE SEQUENCE public."Size_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Size_id_seq" OWNER TO lispberry;

--
-- Name: Size_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lispberry
--

ALTER SEQUENCE public."Size_id_seq" OWNED BY public."Size".id;


--
-- Name: Brand id; Type: DEFAULT; Schema: public; Owner: lispberry
--

ALTER TABLE ONLY public."Brand" ALTER COLUMN id SET DEFAULT nextval('public."Brand_id_seq"'::regclass);


--
-- Name: Category id; Type: DEFAULT; Schema: public; Owner: lispberry
--

ALTER TABLE ONLY public."Category" ALTER COLUMN id SET DEFAULT nextval('public."Category_id_seq"'::regclass);


--
-- Name: Clothes id; Type: DEFAULT; Schema: public; Owner: lispberry
--

ALTER TABLE ONLY public."Clothes" ALTER COLUMN id SET DEFAULT nextval('public."Clothes_id_seq"'::regclass);


--
-- Name: Record id; Type: DEFAULT; Schema: public; Owner: lispberry
--

ALTER TABLE ONLY public."Record" ALTER COLUMN id SET DEFAULT nextval('public."Record_id_seq"'::regclass);


--
-- Name: Size id; Type: DEFAULT; Schema: public; Owner: lispberry
--

ALTER TABLE ONLY public."Size" ALTER COLUMN id SET DEFAULT nextval('public."Size_id_seq"'::regclass);


--
-- Data for Name: Brand; Type: TABLE DATA; Schema: public; Owner: lispberry
--

COPY public."Brand" (id, name) FROM stdin;
50	balenciaga
52	prada
55	adidas
56	nike
\.


--
-- Data for Name: Category; Type: TABLE DATA; Schema: public; Owner: lispberry
--

COPY public."Category" (id, name) FROM stdin;
41	shirts
46	sweaters
\.


--
-- Data for Name: Clothes; Type: TABLE DATA; Schema: public; Owner: lispberry
--

COPY public."Clothes" (id, name, brand_id) FROM stdin;
1	t-shirt	50
2	t-shirt	52
3	long sleeve	52
4	sweater	55
5	sweater	56
\.


--
-- Data for Name: ClothesAndCategory; Type: TABLE DATA; Schema: public; Owner: lispberry
--

COPY public."ClothesAndCategory" (clothes_id, category_id) FROM stdin;
1	41
2	41
3	41
4	46
5	46
\.


--
-- Data for Name: Record; Type: TABLE DATA; Schema: public; Owner: lispberry
--

COPY public."Record" (id, quantity, size_id, clothes_id) FROM stdin;
38	10	39	1
39	20	40	1
40	20	40	2
41	30	40	3
42	20	43	3
43	20	39	4
44	10	39	5
\.


--
-- Data for Name: Size; Type: TABLE DATA; Schema: public; Owner: lispberry
--

COPY public."Size" (id, name) FROM stdin;
39	RU 50
40	RU 48
43	RU 46
\.


--
-- Name: Brand_id_seq; Type: SEQUENCE SET; Schema: public; Owner: lispberry
--

SELECT pg_catalog.setval('public."Brand_id_seq"', 56, true);


--
-- Name: Category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: lispberry
--

SELECT pg_catalog.setval('public."Category_id_seq"', 47, true);


--
-- Name: Clothes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: lispberry
--

SELECT pg_catalog.setval('public."Clothes_id_seq"', 2, true);


--
-- Name: Record_id_seq; Type: SEQUENCE SET; Schema: public; Owner: lispberry
--

SELECT pg_catalog.setval('public."Record_id_seq"', 44, true);


--
-- Name: Size_id_seq; Type: SEQUENCE SET; Schema: public; Owner: lispberry
--

SELECT pg_catalog.setval('public."Size_id_seq"', 45, true);


--
-- Name: Brand Brand_name_key; Type: CONSTRAINT; Schema: public; Owner: lispberry
--

ALTER TABLE ONLY public."Brand"
    ADD CONSTRAINT "Brand_name_key" UNIQUE (name);


--
-- Name: Brand Brand_pkey; Type: CONSTRAINT; Schema: public; Owner: lispberry
--

ALTER TABLE ONLY public."Brand"
    ADD CONSTRAINT "Brand_pkey" PRIMARY KEY (id);


--
-- Name: Category Category_name_key; Type: CONSTRAINT; Schema: public; Owner: lispberry
--

ALTER TABLE ONLY public."Category"
    ADD CONSTRAINT "Category_name_key" UNIQUE (name);


--
-- Name: Category Category_pkey; Type: CONSTRAINT; Schema: public; Owner: lispberry
--

ALTER TABLE ONLY public."Category"
    ADD CONSTRAINT "Category_pkey" PRIMARY KEY (id);


--
-- Name: Clothes Clothes_pkey; Type: CONSTRAINT; Schema: public; Owner: lispberry
--

ALTER TABLE ONLY public."Clothes"
    ADD CONSTRAINT "Clothes_pkey" PRIMARY KEY (id);


--
-- Name: Record Record_pkey; Type: CONSTRAINT; Schema: public; Owner: lispberry
--

ALTER TABLE ONLY public."Record"
    ADD CONSTRAINT "Record_pkey" PRIMARY KEY (id);


--
-- Name: Size Size_name_key; Type: CONSTRAINT; Schema: public; Owner: lispberry
--

ALTER TABLE ONLY public."Size"
    ADD CONSTRAINT "Size_name_key" UNIQUE (name);


--
-- Name: Size Size_pkey; Type: CONSTRAINT; Schema: public; Owner: lispberry
--

ALTER TABLE ONLY public."Size"
    ADD CONSTRAINT "Size_pkey" PRIMARY KEY (id);


--
-- Name: ClothesAndCategory clothesandcategory_pk; Type: CONSTRAINT; Schema: public; Owner: lispberry
--

ALTER TABLE ONLY public."ClothesAndCategory"
    ADD CONSTRAINT clothesandcategory_pk PRIMARY KEY (clothes_id, category_id);


--
-- Name: record_size_id_clothes_id_uindex; Type: INDEX; Schema: public; Owner: lispberry
--

CREATE UNIQUE INDEX record_size_id_clothes_id_uindex ON public."Record" USING btree (size_id, clothes_id);


--
-- Name: Clothes clothes_brand_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: lispberry
--

ALTER TABLE ONLY public."Clothes"
    ADD CONSTRAINT clothes_brand_id_fk FOREIGN KEY (brand_id) REFERENCES public."Brand"(id);


--
-- Name: ClothesAndCategory clothesandcategory_category_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: lispberry
--

ALTER TABLE ONLY public."ClothesAndCategory"
    ADD CONSTRAINT clothesandcategory_category_id_fk FOREIGN KEY (category_id) REFERENCES public."Category"(id);


--
-- Name: ClothesAndCategory clothesandcategory_clothes_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: lispberry
--

ALTER TABLE ONLY public."ClothesAndCategory"
    ADD CONSTRAINT clothesandcategory_clothes_id_fk FOREIGN KEY (clothes_id) REFERENCES public."Clothes"(id);


--
-- Name: Record record_clothes_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: lispberry
--

ALTER TABLE ONLY public."Record"
    ADD CONSTRAINT record_clothes_id_fk FOREIGN KEY (clothes_id) REFERENCES public."Clothes"(id);


--
-- Name: Record record_size_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: lispberry
--

ALTER TABLE ONLY public."Record"
    ADD CONSTRAINT record_size_id_fk FOREIGN KEY (size_id) REFERENCES public."Size"(id);


--
-- PostgreSQL database dump complete
--

