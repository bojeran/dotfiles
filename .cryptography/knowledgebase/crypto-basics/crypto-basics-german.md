# Mathe Grundlagen

## Begriffe

**teilerfremd** = **relativ prim** = wenn es keine natürliche Zahl außer der 
                  Eins gibt, die beide Zahlen teilt
 
**prime Restklassengruppe** = $Z^*_m$ z.B. $Z^*_7 = \{ 1,2,3,4,5,6 \}$ oder 
                              $ Z^*_8 = \{ 1, 3, 5, 7 \} $ 
 
**abelsche Gruppe** = es gilt zusätzlich das Kommutativgesetz 
                    = **kommutative Gruppe**
 
**Homomorphismen** = ??
 
**Halbgruppe** = z.B. $S = (S, ⊛)$ Assoziativität muss gelten, 
                 aber **kein** neutrales Element oder Inverse
 
**Ring** = $(R, +, ⋅)$ wobei $(R, +)$ abelsche Gruppe und 
           $(R, ⋅)$ eine Halbgruppe
 
**Restklasse** = Schreibweise: [a], bei $ ℤ_3 = \{ 0, 1, 2 \} $ gibt es drei 
                 Restklassen 
                 $[0] = \{... ,-3, 0, 3, ...\}; [1] = \{..., -2, 1, 4, ...\}$
 
**zyklische Gruppe** = z.B. $G = (M, ⋅_7)$ und $M={ Z^*_7 }$. 
                       Es gibt ein erzeugendes Element in M z.B. $⟨3⟩$, so dass 
                       jedes Element von M erreicht werden kann mit 
                       $ 3^n \mod 7 $ wobei $ n ∈ ℤ $. 
                       Es heißt zyklisch weil mit einem gewissen n sich die 
                       Zahlen wiederholen. 
                       In diesem Beispiel: 3 (n=1), 2 (n=2), 6 (n=3), 4, 5, 
                       1, 3, ...
 
Kommentar: Um zu prüfen, ob ein Element ein erzeugendes Element von der Gruppe
           ist, siehe Diffie Hellmann.

 
##Gruppen auf endlichen Mengen

Eine Gruppe ist: Eine Menge + EIN binärer Operator wo die 4 Axiome gelten.

4 Axiome:
 * binäre Verknüpfung assoziativ $a ◦ (b ◦ c) = (a ◦ b) ◦ c$
 * Abgeschlossen $a◦b$
 * enthält ein neutrales Element $a ◦ e = a$
 * Für jedes a gibt es ein a' (Inverses) 
   $a ◦ a ′ = e$; z.B. G = (M, ⊕) oder G = (M, ⊛)

**Beispiel**: $G = (M, ⊛)$ wobei $M = ℤ^*_m, ⊛ = ⋅_m$   
              ($⋅_m$ bedeutet "mal modulo m")
 
**Kommentar**: $Z^*_m$ sind alle Teilerfremden Zahlen zu m. 
               Bei Primzahlen sind dies alle Zahlen von 1 bis Primzahl-1. 
               Bei anderen Zahlen sind es weniger z.B. 
               $ Z^*_8 = \{ 1, 3, 5, 7 \} $. 
 
**Begriffe:**
 - *Ordnung der Gruppe*: Anzahl der Elemente der Gruppe; $ ord(G) = |M| $

**Gibt es multiplikatives Inverses herausfinden:** 
  ggT(a, m) = 1, dann gibt es Inverses (Also a und m teilerfremd). 
  Euklidischer Algo.
 
**Multiplikative Inverses berechnen:** Jedes a' austesten oder erweiterter 
  Euklidischer Algo oder Satz nach Euler.
 
**Pre-Kommentar**: ggT (a, b) = γ · a + δ · b   (Jeder ggT(a, b) lässt sich 
  als Linearkombination darstellen)
 
**Erweiterter Euklidischer Algo:**
Ziel ist es die Linearkombination von ggT(a, b) herausfinden. Man spricht auch 
von der Linearfaktorzerlegung.

| a    | b               | $ \lfloor\frac{a}{b}\rfloor $ | d    | x                   | y                                         |
| ---- | --------------- | ----------------------------- | ---- | ------------------- | ----------------------------------------- |
| 102  | 75              | 1                             | 3    | -11                 | 15                                        |
| 75   | 102 mod 75 = 27 | 2                             | 3    | 4                   | -11                                       |
| 27   | 21              | 1                             | 3    | -3                  | 4                                         |
| 21   | 6               | 3                             | 3    | 1                   | -3                                        |
| 6    | 3               | 2                             | 3    | 0  (y von Reihe -1) | 1 ($ x - \lfloor\frac{a}{b}\rfloor * y $) |
| 3    | 0               | -                             | 3    | 1                   | 0                                         |

**Lösung:** ggT(102, 75) = 3 = 102 * (-11) + 75 * 15  
            Inverse zu **a ist x** und zu **b ist y** -> wenn es negativ ist 
            einfach + den Modulo rechnen damit es in die Zahlenmenge passt.
 
**Kommentar:** Die Variable d merkt sich das Ergebnis des ggT wenn der 
               erweiterte Euklid wieder Rückwärts läuft.

**Eulerische Φ Funktion:** 
  Anzahl der Teilerfremdenzahlen. 
  z.B. $ Φ(6) = 2 $ oder $ Φ(7) = 6 $.
  Es gilt $ Φ(p) = p − 1 $ wenn p prim. 
  $Φ(p ⋅ q) = (p − 1) ⋅ (q - 1) $ wenn p, q prim und p ≠ q
  (meistens irgendwie anwendbar)
 
**Satz von Euler:** $ a^{Φ(n)} = 1 \mod n $ wobei n eine natürliche Zahl ist. 
a > 0 und ggT(n, a) = 1. Somit fast immer anwendbar wenn n Prim ist.
$ a^{Φ(n)} = a^{p-1} \mod p $ für a > 0 und p Prim 
 
*Formel für das Inverse:*
$ a^{-1} = a^{Φ(n)-1} \mod n$ für a > 0 und ggt(n, a) = 1
 
**Berechne Multiplikative Inverse mit Satz von Euler:**
Wir haben eine multiplikative Gruppe mit $ M = Z^*_7 $. 
Wir suchen das Inverse von 3. Also nach Satz von Euler: 
$ 3^{Φ(7)-1} \mod 7 = 3^5 \mod 7 = 5 $ -> Inverse ist 5
-> Dies ist sehr effizient, solange wir Primzahlen verwenden. 
-> Wenn die Gruppe jedoch ein Modulo hat, welches nicht eine Primzahl ist, 
dann wird die Berechnung von der Phi Funktion komplizierter 
-> Eine Primfaktorzerlegung ist notwendig z.B. $ Φ(10) = (2-1) * (5-1) = 4 $
 
**Satz von Fermat:** Ist eine Aussage über die Eigenschaft von Primzahlen. 
$ a^p ≡ a \mod p $
$ a^{p-1} ≡ 1 \mod p $  (im Prinzip dasselbe wie der Satz von Euler!! 
Deswegen wird der Satz von Euler auch Satz von Euler-Fermat genannt)
 
**Zu merken:** 

Satz von Fermat-Euler: $ a^{Φ(n)} = 1 \mod n $

Satz von Fermat-Euler Inverse berechnen: $ a^{-1} = a^{Φ(n)-1} \mod n $ 
wenn ggt(a, n) = 1 und a > 0, heißt a kann alles sein, wenn n prim, sonst kann 
man halt nicht alle Zahlen für a verwenden.
Wenn der Exponent groß, dann kann die Exponentation in beliebig kleine 
Portitionen geteilt werden, alla modulare Exponentation. 
$ 11^{51} = 11^5 * 11^5 .... $ oder $ 11^{16} = 11^{2^{4}}  $.

 
## Körper bzw. endliche Zahlenkörper (Galios-Feld)

Ein Körper ist eine Menge mit zwei Verknüpfungen ⊕ und ⊛ und 3 Axiome:

3 Axiome:

- $ (K, ⊕) $ ist eine abelsche Gruppe/kommutative Gruppe mit neutralem Element 0
- $ (K \setminus \{0\}, ⊛) $ ist eine abelsche Gruppe/kommutative Gruppe mit
  neutralem Element 1
- Distributivgesetz gilt: $ a ⋅ (b + c) = a ⋅ b + a ⋅ c $

Ein schnelle Schreibweise für die Gruppe ist z.B. GF(2). Die Menge ist dann 
$ \{0, 1\} $. Mit Primzahlen geht das immer, also allgemein GF(p).
 

## Hashfunktionen

**erstes Urbild Problem**: Nur der Hash-Wert ist gegeben und man versucht 
irgendein Urbild zu finden.

**zweites Urbild Problem**: Sowohl das 1. Urbild, als auch der Hashwert sind 
gegeben und man versucht ein 2. Urbild zu finden. 

***Kollisionsprobleme:***
 - **schwache kollisionsresistente Hashfunktionen / zweites Urbild Problem:** Wenn man beim Angriff das 1. Urbild und den Hash-Wert gegeben hat und man versucht das 2. Urbild zu finden. (selbe wie zweites Urbild Kollisionsresistenz)
 - **stark kollisionsresistente Hashfunktionen:** Wenn man beim Angriff das erste und zweite Urbild frei wählen kann, um für beide den Selben Hash-Wert zu bekommen.

-> Wenn man über einer der letzten beiden Angriffe eine Kollision findet, spricht man von einer Kollision.

**diskreter Logarithmus als Hashfunktion:** $ y = a^x \mod p $



## Vertraulichkeit, Integrität und Authentizität

Authentizität einer Nachricht setzt ihre Integrität voraus.

## Klassische Angriffe

Ciphertext-only-Angriff: 
  Bruteforce den Schlüssel raten. Bei Schwächen, wie z.B. 
  Redundanz -> Sprachliche Statistik muss nurnoch ein kleinerer Schlüsselraum 
  durchsucht werden.

Known-Plaintext-Angriff: 
 Dasselbe wie Ciphertext only nur das man nun das was rauskommen soll schon 
 weiß und vergleichen kann.

Choosen-Plaintext-Angriff:
  Wenn man den Plaintext kennt und man Zugriff auf 
  den Verschlüsselungsmethode, dann versucht man wiederum Wege zu finden 
  einen Brute Force Angriff zu vereinfachen.

Choosen-Ciphertext-Angriff: 
  bekannten Geheimtext mit unbekannten Schlüssel entschlüsseln, um wieder 
  schauen ob sich der Brute Force Angriff vereinfachen lässt.

 
## Klassische Chiffren

Substitutions Chiffren:
  Die Klartext Zeichen werden durch andere ersetzt. 
  Position bleibt die Selbe.

Transposition Chiffren:
  Die Position der Zeichen wird verändert, aber die Zeichen bleiben dieselben. 

Monoalphabetische Chiffre: 
  Jeder Selbe Klartext-Zeichen wird zum Selben Geheimtext-Zeichen.

Polyalphabetische Chiffre: 
  Mehrere Monoalphabetische Chiffren, um dies zu verhindern. 
  (Man weist z.B. demselben Buchstaben der häufig vorkommt mehr Zahlen zu.)

Symmetrisch:
 - **Caesar Chiffre / Verschiebechiffre / ROT13 / Additive Chiffre**: ROT13 
   beliebt, da man einfach (bei 26 Buchstaben) beim nochmaligen verschlüsseln, 
   den Klartext wieder herausbekommt.
 - **Multiplikative Chiffre:** Funktioniert nur wenn alle Zeilen Teilerfremd 
   zum Modulo sind.
 - **One-Time-Pad:** Schlüssel genauso lang wie Klartext, streng zufällig, 
   nur einmal verwenden. Additive Chiffre.
 - **Skytale:** Transpositionschiffre...
 

## Diffie-Hellmann-Schlüsselvereinbarung

Alice und Bob einigen sich auf eine 
**sichere Primzahl p (mit Einsatz einer kleinen Untergruppe)** und ein 
**erzeugendes Element 𝛂**.

**Sichere Primzahl:** Eine Primzahl mit der Eigenschaft $ p = 2⋅q+1 $, 
wobei q prim.
Eine sichere Primzahl vereinfacht die Prüfung von 𝛂 ob es ein erzeugendes 
Element ist (sonst nicht trivial). Dazu muss man die Primfaktorzerlegung von 
Φ(p) kennen. Dies ist trivial für eine sichere Primzahl, da die 
Primfaktorzerlegung von Φ(p) = p-1 = 2⋅q ist. 
Der Nachteil ist der Aufwand der modularen Exponentation von 
3n/2 Multiplikationen bei einer n-Bit Primzahl. Den Aufwand kann man minimieren,
wenn man stattdessen eine Primzahl mit der Eigenschaft $ p = N ⋅ q + 1 $ wählt.
Siehe *Sichere Primzahl mit Einsatz einer kleinen Untergruppe*.

**Erzeugendes Element / Generator**: $ 𝛂 ∈ ℤ^*_p $ ist ein Generator, wenn 
$ 𝛂^{Φ(p)/p_i} \mod p ≠ 1 $, für jeden Primteiler $ p_i $ von Φ(p) stimmt. 
Primteiler sind die Primzahlen in der Primfaktorzerlegung von Φ(p). 
Die Primteiler sind 2 und q, da p eine sichere Primzahl ist. 
Der Algorithmus generiert, also solange zufällige Zahlen zwischen 2 und p-1 bis
die Rechnung für alle Primteiler gilt. Beispiel sichere Primzahl 11 (2 * 5 + 1).
Zufällige Zahl 3: $ 3^{10/2} \mod 11 = 1 $ -> kein Generator. 
Zufällige Zahl 5: $ 5^{10/2} \mod 11 = 1 $ -> kein Generator. 
Zufällige Zahl 8: $ 8^{10/2} \mod 11 = 10 ≠ 1 $ ✔︎
, $ 8^{10/5} \mod 11 = 9 ≠ 1 $ ✔︎
-> 8 bzw. $⟨8⟩$ ist ein Generator bzw. ein erzeugendes Element von 
$  ℤ^*_{11}  $. Nochmal zum Prüfen: 8 (n=1), 9, 6, 4, 10, 3, 2, 5, 7, 1, 8, .... 

Kommentar: Generator prüfen geht auch mit nicht sicheren Primzahlen bzw. 
Teilerfremde Zahlen zu n, also $ 𝛂 ∈ ℤ^*_n $, aber die Primfaktorzerlegung ist 
dann nicht mehr trivial. 

**Generierung einer sicheren Primzahl:** Einfach normal zufällige Primzahl 
generieren und prüfen (MillerRabinTest) und anschließend * 2 + 1 rechnen und 
nochmal Prüfen ob das Ergebnis eine Primzahl ist bis beide eine Primzahl sind. 
Eine einfache Prüfung ist, ob die Zahl ungerade ist und dann einen 
MillerRabinTest durchführen.

**Sichere Primzahl mit Einsatz einer kleinen Untergruppe:** 
Man kann den Aufwand der modularen Exponentation veringern, 
indem man eine Primzahl mit der Eigenschaft: 
$ p = N ⋅ q + 1 $ wählt, wobei $ 2^{255} < q < 2^{256} $ und N eine 
große Gerade Zahl. Anschließend generiert man zufällig eine 
Zahl a ∈ {1, 2, ..., p-1} und berechnet das erzeugende 
Element $ 𝛂 = a^N \mod p $, solange bis $ 𝛂 \mod p ≠ 1 $ und $ 𝛂^q \mod p = 1 $. 

Alice und Bob einigen sich auf sehr große Primzahl p, sowie einer Primwurzel 
g von p, welche zu p-1 teilerfremd ist.

geheimen Zufallszahlen a und b erzeugt
 
$ x = g^a mod p $

$ y = g^b mod p $

$ k = y^a mod p $

$ k' = x^b mod p $

$ k = k' $

 
## RSA

Definition: 

$ 𝒫 = 𝒞 = ℤ_n $
 
$ 𝒦 = \{(n,p,q,e,d) | n = p⋅q, wobei\ p, q\ prim, e⋅d≡1 \mod Φ(n)\} $
 
Schlüssel k = (n, p, q, e, d) ∈ 𝒦
 - Öffentlicher Teil: (n, e)
 - Privater Teil: (p, q, d)

Verschlüsselung: $ enc(k, x) = x^e \mod n $

Entschlüsselung: $ dec(k, y) = y^d \mod n $

Vorgehen: Bob wählt p und q (mindestens 2048 bit pro Primzahl und p!=q und 
nicht zu Nahe beeinander) und berechnet n sowie Φ(n) einfach. 
Jetzt wählt Bob ein e ∈ {1, 2, . . . , Φ(n) − 1}, zufällig und prüft, 
das gcd(e, Φ(n)) = 1 und berechnet dabei gleichzeitig das Inverse von e und 
zwar d mit dem erweiterten Euklid.

Sicherheit basiert auf: Faktorisierungsproblem und das Problem zum Invertieren
der modularen Potenzfunktion

Effiziente Entschlüsselung (Garners Verfahren):

$ a = y^d \mod p $

$ b = y^d \mod q $

$ x = (((a -b)⋅(q^{-1} \mod p)) \mod p ) ⋅ q + b $

Möglich ist Faktorisierung von n bei bekanntem 
Φ(n) -> Gleichungssystem, dann Mitternachtsformel.
$ p_{1,2} = \frac{-b ± \sqrt{b^2-4ac}}{b} $ 
-> a = 1, b = Φ(n) − n − 1, c = n -> wenn lösbar, dann sind 
$ p_1 $ und $ p_2 $ die beiden Faktoren.

Wiener Attacke:
Funktioniert, wenn p und q zu Nahe beieinander sind (q < p < 2q)
und die Binärdarstellung von d weniger als ℓ/4 − 1 Bits groß ist. 
(ℓ ist die Länge der Binärdarstellung von n) ($ 3d < n ^{1/4}) $
dann kann man mit endlichen Kettenbrüchen n herausfinden.
-> .......

Highest Order Bit Attacke:
-> diese ist nur hypothetisch möglich, wenn eine Methode half(y) = ... 
effizient berechnet werden könnte.

 
## ElGamal

$ 𝒫 = ℤ_p $

$ 𝒞 = ℤ_p \times ℤ_p $

$ 𝒦 = \{(p, 𝛂, d, e) | 2 ≤ d ≤ p-2, e ≡ 𝛂^d \mod p\} $

Schlüssel k = (p, 𝛂, d, e)
 - Öffentlicher Teil: (p, 𝛂, e)
 - Privater Teil: d

$ enc(k, x) = y_1, y_2 $ wobei $ y_1 = 𝛂^z \mod p $ und $ y_2 = x⋅e^z \mod p $ 
für eine zufällige, geheime Zahl $ z ∈ Z^*_{p-1} $

$ dec(k, (y_1, y_2)) = y_2(y^d_1)^{-1} \mod p $

Schlüsselgenerierung: Wir wählen eine Primzahl p und ein erzeugendes 
Element 𝛂 von $ Z^*_p $ und es wird der Rest berechnet 
$ e = 𝛂^d \mod p $ wobei d der geheime Teil ist.  2 ≤ d ≤ p-2. 

Verschlüsselung: Man wählt Nachricht x < p und wählt eine Zufallszahl k, die 
teilerfremd zu p - 1 sein muss. Dann berechnet man $ y_1 $ und $ y_2 $.

Entschlüsselung: $ y^d_1 $ berechnen, dann das Inverse bilden und, dann 
$ y_2(y^d_1)^{-1} \mod p $ berechnen.

