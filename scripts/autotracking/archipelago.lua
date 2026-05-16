-- this is an example/ default implementation for AP autotracking
-- it will use the mappings defined in item_mapping.lua and location_mapping.lua to track items and locations via thier ids
-- it will also load the AP slot data in the global SLOT_DATA, keep track of the current index of on_item messages in CUR_INDEX
-- addition it will keep track of what items are local items and which one are remote using the globals LOCAL_ITEMS and GLOBAL_ITEMS
-- this is useful since remote items will not reset but local items might
ScriptHost:LoadScript("scripts/autotracking/item_mapping.lua")
ScriptHost:LoadScript("scripts/autotracking/location_mapping.lua")

CUR_INDEX = -1
SLOT_DATA = {}
ALL_LOCATIONS = {}
LOCAL_ITEMS = {}
GLOBAL_ITEMS = {}
ALL_LOCATIONS = {}
ALL_SETTINGS= { 'cropsanity', 'walnutsanity', 'friendsanity', 'fishsanity', 'hatsanity', 'eatsanity', 'shipsanity', 'craftsanity', 'museumsanity', 'moviesanity', 'skill_progression', 'exclude_ginger_island', 'secretsanity', 'tool_progression', 'building_progression', 'elevator_progression', 'include_endgame_locations', 'quest_locations', 'chefsanity', 'special_order_locations', 'booksanity', 'backpack_progression'}
QUESTS_LOCATIONS = { 717701, 717501, 717502, 717503, 717504, 717505, 717506, 717507, 717508, 717509, 717510, 717511, 717512, 717513, 717514, 717515, 717516, 717517, 717518, 717519, 717520, 717521, 717522, 717523, 717524, 717525, 717526, 717527, 717528, 717529, 717530, 717531, 717532, 717533, 717534, 717535, 717536, 717537, 717538, 717539, 717540, 717541, 717542, 717543, 717544, 717545, 717546, 717547, 717548, 717549, 717550, 717551, 717801, 717802, 717803, 717804, 717805, 717806, 717807, 717808, 717811, 717812, 717813, 717814, 717815, 717816, 717817, 717818, 717821, 717822, 717823, 717824, 717825, 717826, 717827, 717828, 717841, 717842, 717843, 717844, 717845, 717846, 717847, 717848, 717849, 717850, 717851, 717852, 717853, 717854, 717855, 717856, 717857, 717858, 717859, 717860, 717861, 717862, 717863, 717864, 717865, 717866, 717867, 717868, 717869, 717870, 717871, 717872, 719101, 719102, 719103, 719104, 719105, 719106, 719107, 719108, 719109, 719110, 719111, 719112, 719113, 719114, 719115, 719116, 719117, 719118, 719151, 719152, 719153, 719154, 719155, 719156, 719157, 719158, 719159, 719160, 719201, 719202, 719203, 719204, 719205, 719206, 719207, 719208, 719209, 719210, 719211, 719212, 719213, 719214, 719215, 719216 , 717704, 717705, 717706, 717707, 717253, 717254, 717255, 717256, 717901, 717902, 717903, 717904, 717905, 717906, 717907, 717908, 717909, 717910, 717911, 717912, 717913, 717914, 717915, 717916, 717917, 717918, 717919, 717920, 717921, 717922, 717923, 717924, 717925, 717926, 717927, 717928, 717929, 717930, 717931, 717932, 717933, 717934, 717935, 717936, 717937, 717938, 717939, 717940, 717941, 717942, 717943, 717944, 717945, 717946, 717947, 717948, 717949, 717950, 717951, 717952, 717953, 717954, 717955, 717956, 717957, 717958, 717959, 717960, 717961, 717962, 717963, 717964, 717965, 717966, 717967, 717968, 717969, 717970, 774020, 774021, 774022, 774023, 774024, 774025, 774026, 774027 }
CROPSANITY_LOCATIONS = { 719301, 719302, 719303, 719304, 719305, 719306, 719307, 719308, 719309, 719310, 719311, 719312, 719313, 719314, 719315, 719316, 719317, 719318, 719319, 719320, 719321, 719322, 719323, 719324, 719325, 719326, 719327, 719328, 719329, 719330, 719331, 719332, 719333, 719334, 719335, 719336, 719337, 719338, 719339, 719340, 719341, 719342, 719343, 719344, 719345, 719346, 719347, 719348, 719349, 719350, 719351, 719352, 719353 }
FISH_LOCATIONS = { 718001, 718002, 718003, 718004, 718005, 718006, 718007, 718008, 718009, 718010, 718011, 718012, 718013, 718014, 718015, 718016, 718017, 718018, 718019, 718020, 718021, 718022, 718023, 718024, 718025, 718026, 718027, 718028, 718029, 718030, 718031, 718032, 718033, 718034, 718035, 718036, 718037, 718038, 718039, 718040, 718041, 718042, 718043, 718044, 718045, 718046, 718047, 718048, 718049, 718050, 718051, 718052, 718053, 718054, 718055, 718056, 718057, 718058, 718059, 718060, 718061, 718062, 718063, 718064, 718065, 718066, 718067, 718068, 718069, 718070, 718071 }
MINING_LOCATIONS = { 718100, 718101, 718102, 718103, 718104, 718105, 718106, 718107, 718108, 718109, 718110, 718111, 718112, 718113, 718114, 718115, 718116, 718117, 718118, 718119, 718120, 718121, 718122, 718123, 718124, 718125, 718126, 718127, 718128, 718201, 718202, 718203, 718204, 718205, 718206, 718207, 718208, 718209, 718210, 718211, 718212, 718213, 718214, 718215, 718216, 718217, 718218, 718219, 718220, 718221, 718222, 718223, 718224, 718225, 718226, 718227, 718228, 718229, 718230, 718231, 718232, 718233, 718234, 718235, 718236, 718237, 718238, 718239, 718240, 718241, 718242, 718243, 718244, 718245, 718246, 718247, 718248, 718249, 718250, 718251, 718252, 718253, 718254, 718255, 718256, 718257, 718258, 718259, 718260, 718261, 718262, 718263, 718264, 718265, 718266, 718267, 718268, 718269, 718270, 718271, 718272, 718273, 718274, 718275, 718276, 718277, 718278, 718279, 718280, 718281, 718282, 718283, 718284, 718285, 718286, 718287, 718288, 718289, 718290, 718291, 718292, 718293, 718294, 718295 }
FESTIVAL_LOCATIONS = { 719001, 719002, 719003, 719004, 719005, 719006, 719007, 719008, 719009, 719010, 719011, 719012, 719013, 719014, 719015, 719016, 719017, 719018, 719019, 719020, 719021, 719022, 719023, 719024, 719025, 719026, 719027, 719028, 719029, 719030, 719031, 719032, 719033, 719034, 719035, 719036, 719041, 719042, 719043, 719044, 719045, 719046, 719047, 719048, 719049, 719050, 719051, 719052, 719053, 719054, 719055, 719056, 719057, 719058, 719059, 719060, 719061, 719062, 719063, 719064, 719065, 719066, 719067, 719068, 719069, 719070, 719071, 719072, 719073, 719074, 719075, 719076, 719077, 719078, 719079, 719080, 719081, 719082, 719083, 719084, 719085, 719086, 719087, 719088, 719089, 719090, 719091,719092 }
ARCADE_LOCATIONS = { 717601, 717602, 717603, 717604, 717605, 717606, 717607, 717608, 717609, 717610, 717611, 717612, 717613, 717614, 717615, 717616, 717617, 717618, 717619, 717620, 717621 }
SHIPSANITY_LOCATIONS = { 719416, 719417, 719418, 719419, 719420, 719421, 719423, 719424, 719425, 719426, 719427, 719428, 719429, 719430, 719431, 719432, 719433, 719434, 719435, 719436, 719437, 719438, 719439, 719440, 719441, 719442, 719443, 719444, 719445, 719446, 719447, 719612, 719613, 719614, 719615, 719616, 719617, 719618, 719619, 719620, 719621, 719622, 719623, 719624, 719625, 719626, 719627, 719628, 719629, 719630, 719631, 719632, 719633, 719634, 719635, 719636, 719637, 719638, 719639, 719640, 719641, 719642, 719643, 719644, 719645, 719646, 719647, 719648, 719649, 719650, 719651, 719652, 719653, 719654, 719655, 719656, 719657, 719658, 719659, 719660, 719661, 719662, 719663, 719664, 719665, 719666, 719667, 719668, 719669, 719670, 719671, 719672, 719673, 719674, 719675, 719676, 719677, 719678, 719679, 719680, 719681, 719682, 719683, 719684, 719685, 719686, 719687, 719688, 719689, 719690, 719691, 719692, 719693, 719694, 719695, 719696, 719697, 719698, 719699, 719700, 719701, 719702, 719703, 719704, 719705, 719706, 719707, 719708, 719709, 719710, 719711, 719712, 719713, 719714, 719715, 719716, 719717, 719718, 719719, 719720, 719721, 719722, 719723, 719724, 719725, 719726, 719727, 719728, 719729, 719730, 719731, 719732, 719733, 719734, 719735, 719736, 719737, 719738, 719739, 719740, 719741, 719742, 719743, 719744, 719745, 719764, 719765, 719766, 719767, 719768, 719769, 719770, 719771, 719772, 719773, 719776, 719777, 719778, 719779, 719780, 719781, 719782, 719783, 719784, 719786, 719787, 719789, 719790, 719791, 719792, 719796, 719797, 719798, 719799, 719800, 719801, 719802, 719803, 719805, 719806, 719807, 719808, 719809, 719810, 719811, 719812, 719814, 719815, 719816, 719817, 719818, 719819, 719820, 719821, 719822, 719823, 719824, 719825, 719826, 719827, 719828, 719829, 719830, 719831, 719832, 719833, 719834, 719835, 719836, 719871, 719942, 719943, 719944, 719945, 719946, 719947, 719948, 719949, 719950, 719951, 719952, 719953, 719954, 719955, 719956, 720801, 720825, 720827, 720829, 720831, 719555, 719552, 719579, 719569, 719572, 719594, 719574, 719572, 719592, 719586, 719573, 719549, 719584, 719937, 719590, 719562, 719940, 719550, 719585, 719938, 719601, 719902, 719905, 719876, 719911, 719860, 719879, 720864, 719907, 719566, 720815, 719610, 719589, 719597, 719607, 719560, 719595, 719596, 719553, 719611, 719570, 719556, 719593, 719561, 719591, 719599, 720813, 719558, 719583, 719600, 719563, 719548, 719578, 719547, 720810, 719608, 719941, 720823, 719559, 719567, 719554, 719577, 719581, 719580, 719939, 719602, 719606, 719604, 719603, 719605, 719587, 720822, 719598, 719575, 719568, 719564, 719565 }
COOKSANITY_LOCATIONS = { 720201, 720202, 720203, 720204, 720205, 720206, 720207, 720208, 720209, 720210, 720211, 720212, 720213, 720214, 720215, 720216, 720217, 720218, 720219, 720220, 720221, 720222, 720223, 720224, 720225, 720226, 720227, 720228, 720229, 720230, 720231, 720232, 720233, 720234, 720235, 720236, 720237, 720238, 720239, 720240, 720241, 720242, 720243, 720244, 720245, 720246, 720247, 720248, 720249, 720250, 720251, 720252, 720253, 720254, 720255, 720256, 720257, 720258, 720259, 720260, 720261, 720262, 720263, 720264, 720265, 720266, 720267, 720268, 720269, 720270, 720271, 720272, 720273, 720274, 720275, 720276, 720277, 720278, 720279, 720280, 720281, 719472, 719473, 719474, 719475, 719931, 719476, 719477, 719478, 719479, 719480, 719481, 719482, 719483, 719484, 719485, 719486, 719487, 719488, 719489, 719490, 719491, 719492, 719493, 719494, 719495, 719496, 719497, 719498, 719499, 719500, 719501, 719502, 719503, 719932, 719504, 719505, 719506, 719507, 719508, 719509, 719933, 719510, 719511, 719512, 719513, 719514, 719515, 719516, 719517, 719518, 719519, 719935, 719520, 719521, 719522, 719523, 719524, 719525, 719526, 719527, 719528, 719529, 719530, 719531, 719532, 719533, 719534, 719535, 719536, 719537, 719538, 719539, 719540, 719541, 719542, 719543, 719544, 719936, 719545, 719546, 720865, 720301, 720302, 720303, 720304, 720305, 720306, 720307, 720308, 720309, 720310, 720311, 720312, 720313, 720314, 720315, 720316, 720317, 720318, 720319, 720320, 720321, 720322, 720323, 720324, 720325, 720326, 720327, 720328, 720329, 720330, 720331, 720332, 720333, 720334, 720335, 720336, 720337, 720338, 720339, 720340, 720341, 720342, 720343, 720344, 720345, 720346, 720347, 720348, 720349, 720350, 720351, 720352, 720353, 720354, 720355, 720356, 720357, 720358, 720359, 720360, 720361, 720362, 720363, 720364, 720365, 720366, 720367, 720368, 720369, 720370, 720371, 720372, 720373, 720374, 720375, 720376, 720377, 720378, 720379, 720380, 720381 }
MONSTERSANITY_LOCATIONS = { 720010, 720101, 720102, 720103, 720104, 720105, 720106, 720107, 720108, 720109, 720110, 720111, 720112, 720113, 720114, 720115, 720116, 720117, 720118, 720119, 720120, 720121, 720122, 720123, 720124, 720125, 720126, 720127, 720020, 720021, 720022, 720023, 720024, 720025, 720026, 720027, 720028, 720029, 720030, 720031, 720032, 720033, 720034, 720035, 720036, 720037, 720038, 720039, 720040, 720041, 720042, 720043, 720044, 720045, 720046, 720047, 720048, 720049, 720050, 720051, 720052, 720053, 720054, 720055, 720056, 720057, 720058, 720059, 720060, 720061, 720062, 720063, 720064, 720065, 720066, 720067, 720001, 720002, 720003, 720004, 720005, 720006, 720007, 720008, 720009, 720010, 720011, 720012 }
SKILLS_LOCATIONS = { 717301, 717302, 717303, 717304, 717305, 717306, 717307, 717308, 717309, 717310, 717311, 717312, 717313, 717314, 717315, 717316, 717317, 717318, 717319, 717320, 717321, 717322, 717323, 717324, 717325, 717326, 717327, 717328, 717329, 717330, 717331, 717332, 717333, 717334, 717335, 717336, 717337, 717338, 717339, 717340, 717341, 717342, 717343, 717344, 717345, 717346, 717347, 717348, 717349, 717350, 717351, 717352, 717353, 717354, 717355 }
BOOKS_LOCATIONS = { 721001, 721002, 721003, 721004, 721005, 721006, 721007, 721008, 721009, 721010, 721011, 721012, 721013, 721014, 721015, 721016, 721017, 721018, 721019, 721031, 721032, 721033, 721034, 721035, 721036, 721037, 721051, 721052, 721053, 721054, 721055, 721056, 721057, 721058, 721059, 721060, 721061, 721062, 721063, 721064, 721065, 721066, 721067, 721068, 721069, 721070, 721071, 720833, 720834, 720835, 720836, 720837, 720838, 720839, 720840, 720841, 720842, 720843, 720844, 720845, 720846, 720847, 720848, 720849, 720850, 720851, 720852, 720853, 720854, 720855, 720861, 720862, 720866 }
CRAFTSANITY_LOCATIONS = {720401, 720402, 720403, 720404, 720405, 720406, 720407, 720408, 720409, 720410, 720411, 720417, 720412, 720419, 720414, 720416, 720415, 720418, 720413, 720531, 720532, 720420, 720421, 720422, 720423, 720424, 720425, 720426, 720427, 720428, 720429, 720430, 720431, 720432, 720433, 720434, 720435, 720533, 720436, 720437, 720534, 720438, 720439, 720440, 720441, 720442, 720443, 720444, 720445, 720446, 720447, 720448, 720449, 720450, 720451, 720452, 720535, 720453, 720454, 720455, 720456, 720457 ,720458 ,720459, 720549, 720460, 720461, 720536, 720462, 720463, 720464, 720465, 720466, 720467, 720468, 720469, 720470, 720471, 720472, 720473, 720474, 720475, 720476, 720477, 720478, 720479, 720480, 720481, 720537, 720482, 720483, 720484, 720485, 720486, 720487, 720488, 720489, 720490, 720491, 720492, 720493, 720494, 720496, 720497, 720498, 720538, 720501, 720507, 720503, 720504, 720506, 720502, 720505, 720508, 720500, 720509, 720539, 720495, 720499, 720540, 720550, 720510, 720511, 720512, 720513, 720514, 720515, 720541, 720542, 720516, 720517, 720518, 720543, 720519, 720520, 720521, 720522, 720523, 720524, 720525, 720526, 720527, 720528, 720529, 720530, 720544, 720545, 720546, 720547, 720548, 720571, 720577, 720578, 720576, 720551, 720552, 720553, 720554, 720555, 720556, 720557, 720558, 720559, 720560, 720561, 720562, 720575, 720563, 720564, 720565, 720566, 720567, 720568, 720569, 720570, 720572, 720573, 719033, 719032, 720574, 720579, 720580 }
FRIENDSANITY_LOCATIONS = {718301, 718302, 718303, 718304, 718305, 718306, 718307, 718308, 718309, 718310, 718311, 718312, 718313, 718314, 718315, 718316, 718317, 718318, 718319, 718320, 718321, 718322, 718323, 718324, 718325, 718326, 718327, 718328, 718329, 718330, 718331, 718332, 718333, 718334, 718335, 718336, 718337, 718338, 718339, 718340, 718341, 718342, 718343, 718344, 718345, 718346, 718347, 718348, 718349, 718350, 718351, 718352, 718353, 718354, 718355, 718356, 718357, 718358, 718359, 718360, 718361, 718362, 718363, 718364, 718365, 718366, 718367, 718368, 718369, 718370, 718371, 718372, 718373, 718374, 718375, 718376, 718377, 718378, 718379, 718380, 718381, 718382, 718383, 718384, 718385, 718386, 718387, 718388, 718389, 718390, 718391, 718392, 718393, 718394, 718395, 718396, 718397, 718398, 718399, 718400, 718401, 718402, 718403, 718404, 718405, 718406, 718407, 718408, 718409, 718410, 718411, 718412, 718413, 718414, 718415, 718416, 718417, 718418, 718419, 718420, 718421, 718422, 718423, 718424, 718425, 718426, 718427, 718428, 718429, 718430, 718431, 718432, 718433, 718434, 718435, 718436, 718437, 718438, 718439, 718440, 718441, 718442, 718443, 718444, 718445, 718446, 718447, 718448, 718449, 718450, 718451, 718452, 718453, 718454, 718455, 718456, 718457, 718458, 718459, 718460, 718461, 718462, 718463, 718464, 718465, 718466, 718467, 718468, 718469, 718470, 718471, 718472, 718473, 718474, 718475, 718476, 718477, 718478, 718480, 718481, 718482, 718483, 718484, 718485, 718486, 718487, 718488, 718489, 718491, 718492, 718493, 718494, 718495, 718496, 718497, 718498, 718499, 718500, 718502, 718503, 718504, 718505, 718506, 718507, 718508, 718509, 718510, 718511, 718513, 718514, 718515, 718516, 718517, 718518, 718519, 718520, 718521, 718522, 718524, 718525, 718526, 718527, 718528, 718529, 718530, 718531, 718532, 718533, 718535, 718536, 718537, 718538, 718539, 718540, 718541, 718542, 718543, 718544, 718546, 718547, 718548, 718549, 718550, 718551, 718552, 718553, 718554, 718555, 718557, 718558, 718559, 718560, 718561, 718562, 718563, 718564, 718565, 718566, 718568, 718569, 718570, 718571, 718572, 718573, 718574, 718575, 718576, 718577, 718579, 718580, 718581, 718582, 718583, 718584, 718585, 718586, 718587, 718588, 718590, 718591, 718592, 718593, 718594, 718595, 718596, 718597, 718598, 718599, 718601, 718602, 718603, 718604, 718605, 718606, 718607, 718608, 718609, 718610, 718612, 718613, 718614, 718615, 718616, 718617, 718618, 718619, 718620, 718621, 718623, 718624, 718625, 718626, 718627, 718628, 718629, 718630, 718631, 718632, 718634, 718635, 718636, 718637, 718638, 718639, 718640, 718641, 718642, 718643, 718645, 718646, 718647, 718648, 718649, 718650, 718651, 718652, 718653, 718654, 718656, 718657, 718658, 718659, 718660, 718661, 718662, 718663, 718664, 718665, 718667, 718668, 718669, 718670, 718671, 718672, 718673, 718674, 718675, 718676, 718678, 718679, 718680, 718681, 718682, 718683, 718684, 718685, 718686, 718687, 718689, 718690, 718691, 718692, 718693, 718694, 718695, 718696, 718697, 718698, 718700, 718701, 718702, 718703, 718704, 718705, 718706, 718707, 718708, 718709, 718710, 718711, 718712, 718713, 718714}
HATSANITY_LOCATIONS = { 721601, 721602, 721603, 721604, 721605, 721606, 721607, 721608, 721609, 721610, 721611, 721612, 721613, 721614, 721615, 721616, 721617, 721618, 721619, 721620, 721621, 721622, 721623, 721624, 721625, 721626, 721627, 721628, 721629, 721630, 721631, 721632, 721633, 721634, 721635, 721636, 721637, 721638, 721639, 721640, 721641, 721642, 721643, 721644, 721645, 721646, 721647, 721648, 721649, 721650, 721651, 721652, 721653, 721654, 721655, 721656, 721657, 721658, 721659, 721660, 721661, 721662, 721663, 721664, 721665, 721666, 721667, 721668, 721669, 721670, 721671, 721672, 721673, 721674, 721675, 721676, 721677, 721678, 721679, 721680, 721681, 721682, 721683, 721684, 721685, 721686, 721687, 721688, 721689, 721690, 721691, 721692, 721693, 721694, 721695, 721696, 721697, 721698, 721699, 721700, 721701, 721702, 721703, 721704, 721705, 721706, 721707, 721708, 721709, 721710, 721711, 721712, 721713, 721714, 721715, 721716, 721717, 721718, 721719, 721720, 721721, 721722  }
WALNUTSANITY_LOCATIONS = { 721101, 721102, 721103, 721104, 721105, 721106, 721107, 721108, 721109, 721110, 721111, 721112, 721113, 721114, 721115, 721116, 721117, 721118, 721119, 721120, 721121, 721122, 721123, 721124, 721125, 721126, 721127, 721128, 721129, 721130, 721131, 721132, 721133, 721134, 721135, 721136, 721137, 721138, 721139, 721140, 721141, 721142, 721143, 721144, 721145, 721146, 721147, 721148, 721149, 721150, 721151, 721152, 721153, 721154, 721155, 721156, 721157, 721158, 721159, 721160, 721161, 721162, 721163, 721164, 721165, 721166, 721167, 721168, 721169, 721170, 721171, 721172, 721173, 721174, 721175, 721176, 721177, 721178, 721179, 721180, 721181, 721182, 721183, 721184, 721185, 721186, 721187, 721188, 721189, 721190, 721191, 721192, 721193, 721194, 717251}
CC_LOCATIONS = { 717001, 717002, 717003, 717004, 717005, 717006, 717007, 717008, 717009, 717010, 717011, 717012, 717013, 717014, 717015, 717016, 717017, 717018, 717019, 717020, 717021, 717022, 717023, 717024, 717025, 717026, 717027, 717028, 717029, 717030, 717031, 717032, 717033, 717034, 717035, 717036, 717037, 717038, 717039, 717040, 717041, 717042, 717043, 717044, 717045, 717046, 717047, 717048, 717049, 717050, 717051, 717052, 717053, 717054, 717055, 717056, 717057, 717058, 717059, 717060, 717061, 717062, 717063, 717064, 717065, 717066, 717067, 717068, 717069, 717070, 717071, 717072, 717073, 717074, 717075, 717076, 717077, 717078, 717079, 717080, 717081, 717082, 717083, 717084, 717085, 717086, 717087, 717088, 717089, 717090, 717091, 717092, 717093, 717094, 717095, 717096, 717097, 717098, 717099, 717100, 717151, 717152, 717153, 717154, 717155, 717156, 717157, 717158, 717159, 717160, 721401, 721402, 721403, 721404, 721405, 721406, 721407, 721408, 721409, 721410, 721411, 721412, 721413, 721414, 721415, 721416, 721417, 721418, 721419, 721420, 721421, 721422, 721423, 721424, 721425, 721426, 721427, 721428, 721429, 721430, 721431, 721432, 721433, 721434, 721435, 721436, 721437, 721438, 721439, 721440, 721441, 721442, 721443, 721444, 721445, 721446, 721447, 721448, 721449, 721450, 721451, 721452, 721453, 721454, 721455, 721456, 721457, 721458, 721459, 721460, 721461, 721462, 721463, 721464, 721465, 721466, 721467, 721468, 721469, 721470, 721471, 721472, 721473, 721474, 721475, 721476, 721477, 721478, 721479, 721480, 721481, 721482, 721483, 721484, 721485, 721486, 721487, 721488, 721489, 721490, 721491, 721492, 721493, 721494, 721495, 721496, 721497, 721498, 721499, 721500, 721501, 721502, 721503, 721504, 721505, 721506, 721507 }
MOVIESANITY_LOCATIONS = { 721301, 721302, 721303, 721304, 721305, 721306, 721307, 721308, 721309, 721310, 721311, 721312, 721313, 721314, 721315, 721316, 721317, 721318, 721319, 721320, 721321, 721322, 721323, 721324, 721325, 721326, 721327, 721328, 721329, 721330, 721331, 721332, 721333, 721334}
SECRETSANITY_LOCATIONS = { 721201, 721202, 721203, 721204, 721205, 721206, 721207, 721208, 721209, 721210, 721211, 721212, 721213, 721214, 721215, 721216, 721217, 721218, 721219, 721220, 721221, 721222, 721223, 721224, 721225, 721226, 721227, 721228, 721229, 721230, 721231, 721232, 721233, 721234, 721235, 721236, 721237, 721238, 721239, 721240, 721241, 721242, 721243, 721244, 721245, 721246, 721247, 721261, 721262, 721263, 721264, 721265, 721266, 721267, 721268, 721269, 721270, 721271, 721272, 721273, 721274, 721275, 721276, 721277, 721278, 721279, 721280, 721281, 721282, 721283, 721284, 721285, 721286, 721287, 721288, 721289}
EATSANITY_LOCATIONS = { 721751, 721752, 721753, 721754, 721755, 721756, 721757, 721758, 721759, 721760, 721761, 721762, 721763, 721764, 721765, 721766, 721767, 721768, 721769, 721770, 721771, 721772, 721773, 721774, 721775, 721776, 721777, 721778, 721779, 721780, 721781, 721782, 721783, 721784, 721785, 721786, 721787, 721788, 721789, 721790, 721791, 721792, 721793, 721794, 721795, 721796, 721797, 721798, 721799, 721800, 721801, 721802, 721803, 721804, 721805, 721806, 721807, 721808, 721809, 721810, 721811, 721812, 721813, 721814, 721815, 721816, 721817, 721818, 721819, 721820, 721821, 721822, 721823, 721824, 721825, 721826, 721827, 721828, 721829, 721830, 721831, 721832, 721833, 721834, 721835, 721836, 721837, 721838, 721839, 721840, 721841, 721842, 721843, 721844, 721845, 721846, 721847, 721848, 721849, 721850, 721851, 721852, 721853, 721854, 721855, 721856, 721857, 721858, 721859, 721860, 721861, 721862, 721863, 721864, 721865, 721866, 721867, 721868, 721869, 721870, 721871, 721872, 721873, 721874, 721875, 721876, 721877, 721878, 721879, 721880, 721881, 721882, 721883, 721884, 721885, 721886, 721887, 721888, 721889, 721890, 721891, 721892, 721893, 721894, 721895, 721896, 721897, 721898, 721899, 721900, 721901, 721902, 721903, 721904, 721905, 721906, 721907, 721908, 721909, 721910, 721911, 721912, 721913, 721914, 721915, 721916, 721917, 721918, 721919, 721920, 721921, 721922, 721923, 721924, 721925, 721926, 721927, 721928, 721929, 721930, 721931, 721932, 721933, 721934, 721935, 721936, 721937, 721938, 721939, 721940, 721941, 721942, 721943, 721944, 721945, 721946, 721947, 721948, 721949, 721950, 721951, 721952, 721953, 721954, 721955, 721956, 721957, 721958, 721959, 721960, 721961, 721962, 721963, 721964, 721965, 721966, 721967, 721968, 721969, 721970, 721971, 721972, 721973, 721974, 721975, 721976, 721977, 721978, 721979, 721980, 721981, 721982, 721983, 721984, 721985, 721986, 721987, 721988, 721989, 721990, 721991, 721992, 721993, 721994, 721995, 721996, 721997, 721998, 721999, 722000, 722001, 722002, 722003, 722004, 722005, 722006, 722007, 722008, 722009, 722010, 722011, 722012, 722013, 722014, 722015, 722016, 722017, 722018, 722019, 722020, 722021, 722022, 722023, 722024, 722025, 722026, 722027, 722028, 722029, 722030, 722031, 722032, 722033, 722034, 722035, 722036, 722037, 722038, 722039, 722040, 722041, 722042, 722043, 722044, 722045, 722046, 722047, 722048, 722049, 722050, 722051, 722052, 722053, 722054, 722055, 722056, 722057, 722058, 722059, 722060 }

if Highlight then
    HIGHLIGHT_LEVEL= {
        [0] = Highlight.Unspecified,
        [10] = Highlight.NoPriority,
        [20] = Highlight.Avoid,
        [30] = Highlight.Priority,
        [40] = Highlight.None,
        [100] = Highlight.Unspecified, --Filler
        [101] = Highlight.Priority, --Progression
        [102] = Highlight.NoPriority, --Useful
        [103] = Highlight.Priority, -- Prog + Useful
        [104] = Highlight.Avoid, --Trap
        [105] = Highlight.Priority, -- Prog + Trap
        [106] = Highlight.NoPriority, -- Useful + Trap
        [107] = Highlight.Priority, -- Prog + Useful + Trap
    }
end

function dump_table(o, depth)
    if depth == nil then
        depth = 0
    end
    if type(o) == 'table' then
        local tabs = ('\t'):rep(depth)
        local tabs2 = ('\t'):rep(depth + 1)
        local s = '{\n'
        for k, v in pairs(o) do
            if type(k) ~= 'number' then
                k = '"' .. k .. '"'
            end
            s = s .. tabs2 .. '[' .. k .. '] = ' .. dump_table(v, depth + 1) .. ',\n'
        end
        return s .. tabs .. '}'
    else
        return tostring(o)
    end
end

function onClear(slot_data)
    print(dump_table(slot_data))
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
        print(string.format("called onClear, slot_data:\n%s", dump_table(slot_data)))
    end
    SLOT_DATA = slot_data
    CUR_INDEX = -1
    -- reset items
    for _, v in pairs(ITEM_MAPPING) do
        if v[1][1] and v[1][2] then
            if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
                print(string.format("onClear: clearing item %s of type %s", v[1][1], v[1][2]))
            end
            local obj = Tracker:FindObjectForCode(v[1][1])
            if obj then
                if v[1][2] == "toggle" then
                    obj.Active = false
                elseif v[1][2] == "progressive" then
                    obj.CurrentStage = 0
                    obj.Active = false
                elseif v[1][2] == "consumable" then
                    obj.AcquiredCount = 0
                elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
                    print(string.format("onClear: unknown item type %s for code %s", v[1][2], v[1][1]))
                end
            elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
                print(string.format("onClear: could not find object for code %s", v[1][1]))
            end
        end
    end
    -- reset locations
    for _, v in pairs(LOCATION_MAPPING) do
        if v[1][1] then
            if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
                print(string.format("onClear: clearing location %s", v[1][1]))
            end
            local obj = Tracker:FindObjectForCode(v[1][1])
            if obj then
                if v[1][1]:sub(1, 1) == "@" then
                    obj.AvailableChestCount = obj.ChestCount
                else
                    obj.Active = false
                end
            elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
                print(string.format("onClear: could not find object for code %s", v[1][1]))
            end
        end
    end

    -- Copied form AHIT poptracker package; Used to try and read settings form slotData to set them automatically.
    local function setFromSlotData(slot_data_key, item_code_or_location, offset)
        -- Optional offset added to the value read from slot data.
        -- Only applicable to locations and progressive items.
        offset = offset or 0
        local v = slot_data[slot_data_key]
        if not v then
            print(string.format("Could not find key '%s' in slot data", slot_data_key))
            return
        end
        local obj = Tracker:FindObjectForCode(item_code_or_location)

        if not obj then
            print(string.format("Could not find item/location for code '%s'", item_code_or_location))
            return
        end
        
        if item_code_or_location:sub(1, 1) == "@" then
            obj.AvailableChestCount = v + offset
        elseif tonumber(v) then
            if obj.Type == 'toggle' then
                obj.Active = v ~= 0
            elseif obj.Type == 'progressive' then
                obj.CurrentStage =  v + offset
            elseif obj.Type == 'consumable' then
                obj.AcquiredCount = v + offset
            else
                print(string.format("Unsupported item type '%s' for item '%s'", tostring(obj.Type), item_code_or_location))
            end
        else
            if pairs(v) then
                for _, options in pairs(v) do
                    obj = Tracker:FindObjectForCode(slot_data_key .. "_" .. options)
                    obj.CurrentStage = 1
                end
            else
                obj.CurrentStage = 1
            end
        end
    end
    LOCAL_ITEMS = {}
    GLOBAL_ITEMS = {}
    -- manually run snes interface functions after onClear in case we are already ingame
    --if #ALL_LOCATIONS > 0 then
    ALL_LOCATIONS = {}
    --end

    --for _, value in pairs(Archipelago.MissingLocations) do
    --table.insert(ALL_LOCATIONS, #ALL_LOCATIONS + 1, value)
    --end
    --for _, value in pairs(Archipelago.CheckedLocations) do
    --table.insert(ALL_LOCATIONS, #ALL_LOCATIONS + 1, value)
    --end

    PLAYER_ID = Archipelago.PlayerNumber or -1
    TEAM_NUMBER = Archipelago.TeamNumber or 0
    if Archipelago.PlayerNumber > -1 then
        if #ALL_LOCATIONS > 0 then
            ALL_LOCATIONS = {}
        end
        for _, value in pairs(Archipelago.MissingLocations) do
            table.insert(ALL_LOCATIONS, #ALL_LOCATIONS + 1, value)
        end

        for _, value in pairs(Archipelago.CheckedLocations) do
            table.insert(ALL_LOCATIONS, #ALL_LOCATIONS + 1, value)
        end

        HINTS_ID = "_read_hints_"..TEAM_NUMBER.."_"..PLAYER_ID
        Archipelago:SetNotify({HINTS_ID})
        Archipelago:Get({HINTS_ID})
    end

    -- set Settings
    for _, setting_id in ipairs(ALL_SETTINGS) do
        setFromSlotData(setting_id,setting_id)
    end

    for _, value in ipairs(Archipelago.MissingLocations) do
        ALL_LOCATIONS[value] = true
    end

    for _, value in ipairs(Archipelago.CheckedLocations) do
        ALL_LOCATIONS[value] = true
    end
    --print(dump_table(ALL_LOCATIONS))
    local tools = true
    for _, without in ipairs(slot_data["start_without"]) do
        if without == "Tools" then
            tools = false
        else
            
        end
    end
    if tools == true then   
        Tracker:FindObjectForCode("Axe").CurrentStage = Tracker:FindObjectForCode("Axe").CurrentStage + 1
        Tracker:FindObjectForCode("Pick").CurrentStage = Tracker:FindObjectForCode("Pick").CurrentStage + 1
        Tracker:FindObjectForCode("Hoe").CurrentStage = Tracker:FindObjectForCode("Hoe").CurrentStage + 1
        Tracker:FindObjectForCode("Can").CurrentStage = Tracker:FindObjectForCode("Can").CurrentStage + 1
        Tracker:FindObjectForCode("scythe").CurrentStage = Tracker:FindObjectForCode("scythe").CurrentStage + 1
    else
        
    end
    if SLOT_DATA == nil then
        return
    end

    for _, fish_id in ipairs(FISH_LOCATIONS) do
        Tracker:FindObjectForCode(tostring(fish_id)).Active = ALL_LOCATIONS[fish_id] or false
    end

    for _, mining_id in ipairs(MINING_LOCATIONS) do
        Tracker:FindObjectForCode(tostring(mining_id)).Active = ALL_LOCATIONS[mining_id] or false
    end

    for _, cropsanity_id in ipairs(CROPSANITY_LOCATIONS) do
        Tracker:FindObjectForCode(tostring(cropsanity_id)).Active = ALL_LOCATIONS[cropsanity_id] or false
    end

    for _, festival_id in ipairs(FESTIVAL_LOCATIONS) do
        Tracker:FindObjectForCode(tostring(festival_id)).Active = ALL_LOCATIONS[festival_id] or false
    end

    for _, quests_id in ipairs(QUESTS_LOCATIONS) do
        Tracker:FindObjectForCode(tostring(quests_id)).Active = ALL_LOCATIONS[quests_id] or false
    end

    for _, arcade_id in ipairs(ARCADE_LOCATIONS) do
        Tracker:FindObjectForCode(tostring(arcade_id)).Active = ALL_LOCATIONS[arcade_id] or false
    end

    for _, shipsanity_id in ipairs(SHIPSANITY_LOCATIONS) do
        Tracker:FindObjectForCode(tostring(shipsanity_id)).Active = ALL_LOCATIONS[shipsanity_id] or false
    end

    for _, cooking_id in ipairs(COOKSANITY_LOCATIONS) do
        Tracker:FindObjectForCode(tostring(cooking_id)).Active = ALL_LOCATIONS[cooking_id] or false
    end

    for _, skills_id in ipairs(SKILLS_LOCATIONS) do
        Tracker:FindObjectForCode(tostring(skills_id)).Active = ALL_LOCATIONS[skills_id] or false
    end
    
    for _, books_id in ipairs(BOOKS_LOCATIONS) do
        Tracker:FindObjectForCode(tostring(books_id)).Active = ALL_LOCATIONS[books_id] or false
    end

    for _, monster_id in ipairs(MONSTERSANITY_LOCATIONS) do
        Tracker:FindObjectForCode(tostring(monster_id)).Active = ALL_LOCATIONS[monster_id] or false
    end

    for _, craft_id in ipairs(CRAFTSANITY_LOCATIONS) do
        Tracker:FindObjectForCode(tostring(craft_id)).Active = ALL_LOCATIONS[craft_id] or false
    end

    for _, friend_id in ipairs(FRIENDSANITY_LOCATIONS) do
        Tracker:FindObjectForCode(tostring(friend_id)).Active = ALL_LOCATIONS[friend_id] or false
    end

    for _, hat_id in ipairs(HATSANITY_LOCATIONS) do
        Tracker:FindObjectForCode(tostring(hat_id)).Active = ALL_LOCATIONS[hat_id] or false
    end

    for _, walnut_id in ipairs(WALNUTSANITY_LOCATIONS) do
        Tracker:FindObjectForCode(tostring(walnut_id)).Active = ALL_LOCATIONS[walnut_id] or false
    end

    for _, cc_id in ipairs(CC_LOCATIONS) do
        Tracker:FindObjectForCode(tostring(cc_id)).Active = ALL_LOCATIONS[cc_id] or false
    end

    for _, secret_id in ipairs(SECRETSANITY_LOCATIONS) do
        Tracker:FindObjectForCode(tostring(secret_id)).Active = ALL_LOCATIONS[secret_id] or false
    end

    for _, movie_id in ipairs(MOVIESANITY_LOCATIONS) do
        Tracker:FindObjectForCode(tostring(movie_id)).Active = ALL_LOCATIONS[movie_id] or false
    end

    for _, eat_id in ipairs(EATSANITY_LOCATIONS) do
        Tracker:FindObjectForCode(tostring(eat_id)).Active = ALL_LOCATIONS[eat_id] or false
    end

    for _, walnut_id in ipairs(WALNUTSANITY_LOCATIONS) do
        Tracker:FindObjectForCode(tostring(walnut_id)).Active = ALL_LOCATIONS[walnut_id] or false
    end

    -- for _, id in pairs(ALL_LOCATIONS) do
    --    print(id .. " is there")
    -- end
    -- print(dump_table(slot_data))
end

-- called when an item gets collected
function onItem(index, item_id, item_name, player_number)
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
        print(string.format("called onItem: %s, %s, %s, %s, %s", index, item_id, item_name, player_number, CUR_INDEX))
    end
    print(string.format("called onItem: %s, %s, %s, %s, %s", index, item_id, item_name, player_number, CUR_INDEX))
    if index <= CUR_INDEX then
        return
    end
    local is_local = player_number == Archipelago.PlayerNumber
    CUR_INDEX = index;
    local v = ITEM_MAPPING[item_id]
    if not v then
        if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
            print(string.format("onItem: could not find item mapping for id %s", item_id))
        end
        return
    end
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
        print(string.format("onItem: code: %s, type %s", v[1][1], v[1][2]))
    end
    if not v[1] then
        return
    end
    local obj = Tracker:FindObjectForCode(v[1][1])
    if obj then
        print(string.format("object: %s  code: %s", obj, v[1][1]))
        if v[1][2] == "toggle" then
            obj.Active = true
        elseif v[1][2] == "progressive" then
            if obj.Active then
                obj.CurrentStage = obj.CurrentStage + 1
            else
                obj.Active = true
            end
        elseif v[1][2] == "consumable" then
            obj.AcquiredCount = obj.AcquiredCount + obj.Increment * (v[1][3] or 1)
        elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
            print(string.format("onItem: unknown item type %s for code %s", v[1][2], v[1][1]))
        end
    else
        print(string.format("onItem: could not find object for code %s", v[1][1]))
    end
    -- track local items via snes interface
    if is_local then
        if LOCAL_ITEMS[v[1][1]] then
            LOCAL_ITEMS[v[1][1]] = LOCAL_ITEMS[v[1][1]] + 1
        else
            LOCAL_ITEMS[v[1][1]] = 1
        end
    else
        if GLOBAL_ITEMS[v[1][1]] then
            GLOBAL_ITEMS[v[1][1]] = GLOBAL_ITEMS[v[1][1]] + 1
        else
            GLOBAL_ITEMS[v[1][1]] = 1
        end
    end
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
        print(string.format("local items: %s", dump_table(LOCAL_ITEMS)))
        print(string.format("global items: %s", dump_table(GLOBAL_ITEMS)))
    end
    if PopVersion < "0.20.1" or AutoTracker:GetConnectionState("SNES") == 3 then
        -- add snes interface functions here for local item tracking
    end
end

--called when a location gets cleared
function onLocation(location_id, location_name)
    MANUAL_CHECKED = false
    local location_array = LOCATION_MAPPING[location_id]
    if not location_array or not location_array[1] then
        print(string.format("onLocation: could not find location mapping for id %s", location_id))
        return
    end

    for _, location in pairs(location_array) do
        local location_obj = Tracker:FindObjectForCode(location)
        -- print(location, location_obj)
        if location_obj then
            if location:sub(1, 1) == "@" then
                location_obj.AvailableChestCount = location_obj.AvailableChestCount - 1
            else
                location_obj.Active = true
            end
        else
            print(string.format("onLocation: could not find location_object for code %s", location))
        end
    end
    MANUAL_CHECKED = true
end

function OnNotify(key, value, old_value)
    print("OnNotify", key, value, old_value)
    if value ~= old_value and key == HINTS_ID then
        Tracker.BulkUpdate = true
        for _, hint in ipairs(value) do
            if hint.finding_player == Archipelago.PlayerNumber then
                if hint.status == 0 then
                    UpdateHints(hint.location, 100+hint.item_flags)
                else
                    UpdateHints(hint.location, hint.status)
                end
            end
        end
        Tracker.BulkUpdate = false
    end
end

function OnNotifyLaunch(key, value)
    if key == HINTS_ID then
        Tracker.BulkUpdate = true
        for _, hint in ipairs(value) do
            if hint.finding_player == Archipelago.PlayerNumber then
                if hint.status == 0 then
                    UpdateHints(hint.location, 100+hint.item_flags)
                else
                    UpdateHints(hint.location, hint.status)
                end
            end
        end
        Tracker.BulkUpdate = false
    end
end

function UpdateHints(locationID, status) -->
    if Highlight then
        -- print(locationID, status)
        local location_table = LOCATION_MAPPING[locationID]
        for _, location in ipairs(location_table) do
            if location:sub(1, 1) == "@" then
                local obj = Tracker:FindObjectForCode(location)

                if obj then
                    if TROLL_PLAYER and HIGHLIGHT_LEVEL[status] == Highlight.Avoid then
                        obj.Highlight = HIGHLIGHT_LEVEL[30]
                    else
                        obj.Highlight = HIGHLIGHT_LEVEL[status]
                    end
                else
                    print(string.format("No object found for code: %s", location))
                end
            end
        end
    end
end

-- add AP callbacks
-- un-/comment as needed
Archipelago:AddClearHandler("clear handler", onClear)
Archipelago:AddItemHandler("item handler", onItem)
Archipelago:AddLocationHandler("location handler", onLocation)
Archipelago:AddSetReplyHandler("notify handler", OnNotify)
Archipelago:AddRetrievedHandler("notify launch handler", OnNotifyLaunch)

