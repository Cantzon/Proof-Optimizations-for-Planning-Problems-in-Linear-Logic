
(setf result '(
   (time 36.667)
   (nodes 191)
   (exhaustedp nil)
   (solutionp t)
   (solution-length 17)
   (solution ((go researcher georgiatech hartsfield atlanta) (fly-domestic researcher usa hartsfield atlanta dulles washington)
              (go researcher dulles postoffice washington) (pick-up researcher passport1 postoffice) (go researcher postoffice dulles washington)
              (fly-domestic researcher usa dulles washington hartsfield atlanta) (fly-domestic researcher usa hartsfield atlanta bostonport boston)
              (go researcher bostonport kinkos boston) (pick-up researcher akr kinkos) (go researcher kinkos bostonport boston)
              (fly-domestic researcher usa bostonport boston hartsfield atlanta) (go researcher hartsfield georgiatech atlanta)
              (go researcher georgiatech kingstavern atlanta) (pick-up researcher luggage1 kingstavern) (go researcher kingstavern georgiatech atlanta)
              (go researcher georgiatech hartsfield atlanta) (fly-international researcher passport1 usa hartsfield atlanta usa athensport iraklion greece)))))

(setf problem-solved 
   "/afs/cs.cmu.edu/user/centaur/Research/Prodigy/domains/stinger/probs/nightmare-conference")
(setf goal '((in-city-p researcher iraklion) (holding researcher akr) (holding researcher luggage1)))

(setf case-objects '((usa country) (uk country) (greece country) (atlanta city) (boston city) (washington city) (inverness city) (iraklion city)
                     (hartsfield airport) (athensport airport) (gatwick airport) (bostonport airport) (dulles airport) (georgiatech location)
                     (kinkos location) (postoffice location) (kingstavern location) (researcher person) (passport1 passport) (akr presentation)
                     (luggage1 luggage)))

(setf insts-to-vars '(
   (usa . <country37>) 
   (uk . <country44>) 
   (greece . <country30>) 
   (atlanta . <city54>) 
   (boston . <city24>) 
   (washington . <city54>) 
   (inverness . <city43>) 
   (iraklion . <city89>) 
   (hartsfield . <airport76>) 
   (athensport . <airport85>) 
   (gatwick . <airport36>) 
   (bostonport . <airport39>) 
   (dulles . <airport75>) 
   (georgiatech . <location83>) 
   (kinkos . <location87>) 
   (postoffice . <location86>) 
   (kingstavern . <location75>) 
   (researcher . <person54>) 
   (passport1 . <passport90>) 
   (akr . <presentation43>) 
   (luggage1 . <luggage33>) 
))

(setf footprint-by-goal '(
   ((holding researcher luggage1) (nationality researcher usa) (in-city-l postoffice washington) (in-city-l kinkos boston) (in-city-l kingstavern atlanta)
    (~ (immobile luggage1)) (at-loc-o luggage1 kingstavern) (in-country boston usa) (in-city-l bostonport boston) (in-country washington usa)
    (in-city-l dulles washington) (in-country atlanta usa) (at-loc-p researcher georgiatech) (in-city-p researcher atlanta) (in-city-l georgiatech atlanta)
    (in-city-l hartsfield atlanta))
   ((holding researcher akr) (nationality researcher usa) (in-city-l postoffice washington) (in-city-l kinkos boston) (at-loc-o akr kinkos)
    (~ (immobile akr)) (in-country boston usa) (in-city-l bostonport boston) (in-country washington usa) (in-city-l dulles washington)
    (in-country atlanta usa) (at-loc-p researcher georgiatech) (in-city-p researcher atlanta) (in-city-l georgiatech atlanta) (in-city-l hartsfield atlanta))
   ((in-city-p researcher iraklion) (nationality researcher usa) (in-city-l postoffice washington) (at-loc-o passport1 postoffice) (~ (immobile passport1))
    (in-country iraklion greece) (in-city-l athensport iraklion) (in-country boston usa) (in-city-l bostonport boston) (in-city-l kingstavern atlanta)
    (in-city-l kinkos boston) (in-country washington usa) (in-city-l dulles washington) (in-country atlanta usa) (at-loc-p researcher georgiatech)
    (in-city-p researcher atlanta) (in-city-l georgiatech atlanta) (in-city-l hartsfield atlanta))))
