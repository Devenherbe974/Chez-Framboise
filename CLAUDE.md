# CLAUDE.md — Mémoire du projet Chez Framboise

> Fichier de contexte pour Claude. Lu automatiquement à chaque nouvelle session.
> **À mettre à jour à la fin de chaque session de travail importante.**

---

## 🏡 Le projet

Site vitrine pour **Chez Framboise**, une chambre d'hôtes située à **Salazie** (Cirque de Salazie, La Réunion — microrégion est, végétation tropicale humide).

- **Propriétaires-hôtes** : Françoise et Fred
- **Origine** : **Madagascar** (à exploiter discrètement dans le design — voir "En attente" plus bas)
- **Note Booking.com** : 9,4/10 · +200 voyageurs accueillis · +5 ans d'activité
- **Coordonnées GPS** : −21,047374, 55,529125
- **Réservation** : via Booking.com (lien direct dans le site)

## 👤 Propriétaire du projet

- **Utilisateur** : Devenherbe974
- **GitHub** : https://github.com/Devenherbe974
- **OS** : Windows 11, FR
- **Connaissance technique** : débutant (premier compte GitHub créé pendant la session V1)
- **Préférence de communication** : français, ton naturel, explications pédagogiques quand nécessaire

## 🔗 Liens importants

| Quoi | Où |
|---|---|
| Dossier local | `C:\Users\Utilisateur\Desktop\Chez Framboise` |
| Dépôt GitHub | https://github.com/Devenherbe974/Chez-Framboise |
| Site en production (GitHub Pages) | https://devenherbe974.github.io/Chez-Framboise/ |
| Réservation Booking | https://www.booking.com/hotel/re/chez-framboise.fr.html |

---

## 🛠 Stack & environnement

- **Aucun framework** : HTML5 + CSS3 + JS vanilla
- **Tout est dans `index.html`** : CSS inline dans `<style>`, JS inline dans `<script>` (les fichiers `style.css` et `script.js` séparés existent mais sont des reliquats, non utilisés)
- **Dev local** : serveur HTTP via `py -m http.server 8080` (config dans `.claude/launch.json`, ignorée par git)
- **Runtimes installés** : Git 2.54, Python 3.11 (via `py`). PAS de Node, npm, php
- **Preview Claude Code** : utiliser `mcp__Claude_Preview__preview_start` avec le nom "Chez Framboise — site statique"

## 📁 Structure des fichiers

```
Chez Framboise/
├── index.html              ← LE fichier principal (tout est dedans)
├── style.css               ← reliquat (CSS dupliqué inline dans index.html)
├── script.js               ← reliquat (JS dupliqué inline dans index.html)
├── images/                 ← 9 photos, optimisées 1600px / qualité 82%
│   ├── 1.jpg               panorama montagnes (hero)
│   ├── 21.jpg              portrait Françoise & Fred (section hôtes)
│   ├── 22.jpg              cascade verticale (galerie)
│   ├── chambre 1.jpg       chambre carrelée, vue jardin (galerie)
│   ├── chambre 2.jpg       chambre lambris bois (galerie)
│   ├── ext 1.jpg           jardin avec banc (galerie)
│   ├── ext 2.jpg           jardin avec palmier (section "Le lieu")
│   ├── salon.jpg           salon-véranda (galerie)
│   └── serre.jpg           serre aux orchidées (galerie)
├── embed-images.ps1        injecte les images en base64 dans index.html (dev portable)
├── unembed-images.ps1      inverse — restaure les références externes
├── optimize-images.ps1     redimensionne + recompresse les JPG
├── CLAUDE.md               ← ce fichier
├── .gitignore              ignore .claude/, .vscode/, etc.
└── .claude/launch.json     config dev server (gitignored)
```

---

## 🎨 Identité visuelle (à respecter)

### Palette exacte

| Token CSS | Hex | Usage |
|---|---|---|
| `--cream` | `#FAF7F2` | Fond principal |
| `--sand` | `#E8DFD0` | Cards, séparateurs |
| `--ink` | `#1A2420` | Texte principal |
| `--forest` | `#2D4A3E` | Vert dominant désaturé (palmes !) |
| `--moss` | `#5A7361` | Texte secondaire |
| `--bark` | `#8A8479` | Légendes, méta |
| `--emerald` | `#3FA66B` | Accent vif |
| `--framboise` | `#C0395B` | **Signature de marque** |
| `--coral` | `#E87356` | Accent secondaire |

**Règle :** ~75 % crème + verts désaturés. Framboise et corail = ponctuations chromatiques uniquement (jamais en aplat large).

### Typographies (actuelles)

- **Titres** : `Palatino Linotype, Palatino, Book Antiqua, Georgia, serif` (polices système)
- **Corps** : `system-ui, -apple-system, 'Segoe UI', Roboto, sans-serif`
- **Note** : Google Fonts (Cormorant Garamond + Inter) ont été retirés car bloqués par le sandbox de preview. Pour la V2 sur vrai serveur, on peut les rétablir.

### Principes graphiques

- Formes organiques, courbes douces, motifs végétaux SVG
- Animations subtiles (reveal au scroll, hover states, palmes en fond)
- Mobile-first strict, breakpoints à 640 / 900 / 1100 px

---

## 🏗 Structure du site (sections dans l'ordre)

1. **Header** sticky (transparent → solide au scroll)
2. **Hero** plein écran (image `1.jpg`, titre poétique, CTA Booking)
3. **Le lieu** (`#lieu`) — présentation + stats (note, voyageurs, années) + image `ext 2.jpg`
4. **Hôtes** — portrait Françoise & Fred + citation Booking
5. **Galerie** (`#galerie`) — 6 images en grille asymétrique (lightbox au clic)
6. **Services** (`#services`) — 8 cards icônes SVG (Wi-Fi, parking, petit-déj, PMR, terrasse, non-fumeur, conseils, randonnée)
7. **Avis** — 3 témoignages (Jean, Valérie, Céline)
8. **Séjour** (`#sejour`) — fond vert sombre, CTA réservation
9. **Contact** (`#contact`) — bloc carte statique (PAS d'iframe Google : bloqué en preview)
10. **Outro** — phrase de clôture : *"Au plaisir de vous accueillir bientôt chez nous."*
11. **Footer** sombre

### Animation de fond (présente partout sauf sections opaques)

- 4 palmes SVG line-art en `position: fixed`, opacité ~13%
- Balancement désynchronisé (3-4° d'amplitude, 6,5 à 7,5 s/cycle)
- Visibles uniquement sur les sections claires/transparentes (lieu, galerie, contact, outro)
- L'animation **n'est PAS désactivée** par `prefers-reduced-motion` (amplitude sous le seuil WCAG)

---

## 📋 Décisions prises & rationale

| Décision | Pourquoi |
|---|---|
| Tout inline dans `index.html` | Le sandbox de preview Claude ne sert qu'un seul fichier |
| Polices système (Palatino/system-ui) | Google Fonts bloqué par le sandbox |
| Carte statique au lieu d'iframe Google Maps | `maps.google.com` bloqué par le sandbox |
| Images URL-encodées (`chambre%201.jpg`) | Espaces dans les noms de fichiers |
| Images redimensionnées 1600 px / 82 % qualité | Réduction 96 % du poids (56 Mo → 2,5 Mo) |
| `.outro` rendue transparente | Pour laisser voir les palmes en fond |
| Légendes de galerie retirées | Demande utilisateur (V1) |
| Phrase poétique d'introduction du hero retirée | Demande utilisateur (V1) — titre seul plus percutant |
| Feuille `.leaf-deco` au-dessus de la photo "Le lieu" retirée | Demande utilisateur (V1) |

---

## ⏳ En attente / pour la V2

### Clin d'œil Madagascar (à trancher)

J'ai proposé 5 idées, l'utilisateur a dit "nous verrons ça plus tard" :

1. **Salutation "Tonga soa"** (bienvenue en malgache) — narratif, ultra subtil
2. **Une palme transformée en Ravinala** (l'arbre du voyageur, emblème national) — subtil et symbolique
3. **Micro-bande tricolore blanc/rouge/vert** comme séparateur récurrent (dans le logo, sous les eyebrows, footer)
4. **Phrase narrative** dans la section "Vos hôtes" mentionnant Madagascar
5. **Mini-drapeau SVG** sous le portrait des hôtes

**Mon coup de cœur :** combo 1 + 3. **Préférence intellectuelle :** option 2 (Ravinala).

### Autres axes V2 possibles (du rapport initial)

- Conversion JPG → WebP/AVIF pour gagner encore en poids
- Localisation EN/FR
- Page dédiée "Les environs" (Voile de la Mariée, Hell-Bourg, etc.)
- Système de témoignages dynamique (API Booking / Google Reviews)
- Carte interactive Leaflet (style aquarelle) en remplacement du bloc statique
- Mode sombre
- CMS léger pour que Françoise & Fred éditent eux-mêmes

---

## 🔄 Workflow git (sauvegarde sur GitHub)

L'utilisateur ne connaît pas git. **C'est moi qui fais.**

À chaque fin de modification importante :

```powershell
Set-Location "C:\Users\Utilisateur\Desktop\Chez Framboise"
git add .
git commit -m "Message clair en français"
git push
```

Après push, GitHub Pages reconstruit le site en 1-2 min.

**Convention de message de commit** : verbe d'action en début, ton naturel, explique le pourquoi.

---

## 📜 Historique des versions

### V1 — finalisée et en ligne (session 1)

- ✅ Refonte complète du site (CSS, JS, structure)
- ✅ Identité visuelle posée
- ✅ Images optimisées (-96 %)
- ✅ Push initial GitHub
- ✅ GitHub Pages activé par l'utilisateur
- ✅ Animation palmes en fond
- ✅ Suppression des éléments superflus (légendes galerie, lead hero, leaf-deco)

### V2 — en cours

À démarrer : choix du clin d'œil Madagascar (cf. ci-dessus).

---

## 💬 Pour la prochaine session

**Reprends ici** : on est en attente de la décision de l'utilisateur sur le clin d'œil Madagascar (option 1 à 5 ou combinaison). Une fois validée, l'implémenter, committer, pousser.

**Vérifier d'abord** : `git status` pour voir si l'utilisateur a fait des modifs manuelles entre deux sessions.

**Ne pas oublier** : mettre à jour ce CLAUDE.md à la fin de la session.
