import 'dart:typed_data';

import 'package:booknest/db/book.dart';
import 'package:booknest/pages/best_sellers_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';

// Helper function to load image bytes from assets
Future<Uint8List?> _getImageBytesFromAsset(String assetPath) async {
  try {
    final byteData = await rootBundle.load(assetPath);
    return byteData.buffer.asUint8List();
  } catch (e) {
    print('Error loading asset image $assetPath: $e');
    //return Uint8List(0); // Return an empty Uint8List or null on error
    return null;
  }
}

//for regular
// final cinematic = [
//   {
//     'title': 'Lord Of The Rings',
//     'image': 'assets/bookImages/bestsellerpage/lotr.jpg',
//     'price': 100.0,
//     'author': 'by J. R. R. Tolkien',
//     'description':
//         'Continuing the story begun in The Hobbit, all three parts of the epic masterpiece, The Lord of the Rings, in one paperback. Features the definitive edition of the text, fold-out flaps with the original two-colour maps, and a revised and expanded index.Sauron, the Dark Lord, has gathered to him all the Rings of Power – the means by which he intends to rule Middle-earth. All he lacks in his plans for dominion is the One Ring – the ring that rules them all – which has fallen into the hands of the hobbit, Bilbo Baggins.In a sleepy village in the Shire, young Frodo Baggins finds himself faced with an immense task, as the Ring is entrusted to his care. He must leave his home and make a perilous journey across the realms of Middle-earth to the Crack of Doom, deep inside the territories of the Dark Lord. There he must destroy the Ring forever and foil the Dark Lord in his evil purpose.Since it was first published in 1954, The Lord of the Rings has been a book people have treasured. Steeped in unrivalled magic and otherworldliness, its sweeping fantasy has touched the hearts of young and old alike.This single-volume paperback edition is the definitive text, fully restored with almost 400 corrections – with the full co-operation of Christopher Tolkien – and features a striking new cover.',
//     'category': 'cinematic', // <-- ADD THIS LINE
//     'createdAt': DateTime.now().toIso8601String(),
//   },
//   {
//     'title': 'Horrid the Henry',
//     'image': 'assets/bookImages/newarrival/horridthehenry.webp',
//     'price': 200.0,
//     'author': 'by by Francesca Simon',
//     'description':
//         'Early Readers are stepping stones from picture books to reading books. A blue Early Reader is perfect for sharing and reading together. A red Early Reader is the next step on your reading journey.The Queen is coming to visit Horrid Henrys school. The real live Queen! Henry cant believe it. But when Miss Battle-Axe puts him in the back row, Henry is furious. Now how is he meant to find out how many TVs she has? Somehow Henry has to get himself noticed - and show the Queen just how horrid he can be . . .',
//     'category': 'cinematic', // <-- ADD THIS LINE
//     'createdAt': DateTime.now().toIso8601String(),
//   },
//   {
//     'title': 'Harry Potter',
//     'image': 'assets/bookImages/harrypotter.jpg',
//     'price': 200.0,
//     'author': 'by Andrzej Sapkowski',
//     'description':
//         ';Meet Geralt of Rivia - the Witcher - who holds the line against the monsters plaguing humanity in the bestselling series that inspired the Witcher video games and a major Netflix show.The Witchers magic powers and lifelong training have made him a brilliant fighter and a merciless assassin.Yet he is no ordinary killer: he hunts the vile fiends that ravage the land and attack the innocent.But not everything monstrous-looking is evil; not everything fair is good . . . and in every fairy tale there is a grain of truth.Translated by Danusia Stok and David French.Andrzej Sapkowski, winner of the World Fantasy Lifetime Achievement award, started an international phenomenon with his Witcher series. This boxed set contains all eight books: THE LAST WISH, SWORD OF DESTINY, BLOOD OF ELVES, TIME OF CONTEMPT, BAPTISM OF FIRE, THE TOWER OF THE SWALLOW, THE LADY OF THE LAKE, SEASON OF STORMS.',
//     'category': 'cinematic', // <-- ADD THIS LINE
//     'createdAt': DateTime.now().toIso8601String(),
//   },
//   {
//     'title': 'The Witcher',
//     'image': 'assets/bookImages/the_witcher.jpg',
//     'price': 200.0,
//     'author': 'by by J. K. Rowling',
//     'description':
//         'Harry Potter has never even heard of Hogwarts when the letters start dropping on the doormat at number four, Privet Drive. Addressed in green ink on yellowish parchment with a purple seal, they are swiftly confiscated by his grisly aunt and uncle. Then, on Harrys eleventh birthday, a great beetle-eyed giant of a man called Rubeus Hagrid bursts in with some astonishing news: Harry Potter is a wizard, and he has a place at Hogwarts School of Witchcraft and Wizardry. An incredible adventure is about to begin!These new editions of the classic and internationally bestselling, multi-award-winning series feature instantly pick-up-able new jackets by Jonny Duddle, with huge child appeal, to bring Harry Potter to the next generation of readers. Its time to PASS THE MAGIC ON',
//     'category': 'cinematic', // <-- ADD THIS LINE
//     'createdAt': DateTime.now().toIso8601String(),
//   },
//   {
//     'title': 'Demon Slayer',
//     'image': 'assets/bookImages/Demon_Slayer.jpg',
//     'price': 500.0,
//     'author': 'by Koyoharu Gotouge',
//     'description':
//         'Tanjiro sets out on the path of the Demon Slayer to save his sister and avenge his family! In Taisho-era Japan, Tanjiro Kamado is a kindhearted boy who makes a living selling charcoal. But his peaceful life is shattered when a demon slaughters his entire family. His little sister Nezuko is the only survivor, but she has been transformed into a demon herself! Tanjiro sets out on a dangerous journey to find a way to return his sister to normal and destroy the demon who ruined his life. Learning to destroy demons won’t be easy, and Tanjiro barely knows where to start. The surprise appearance of another boy named Giyu, who seems to know what’s going on, might provide some answers—but only if Tanjiro can stop Giyu from killing his sister first!',
//     'category': 'cinematic', // <-- ADD THIS LINE
//     'createdAt': DateTime.now().toIso8601String(),
//   },
//   {
//     'title': 'Dune',
//     'image': 'assets/bookImages/cinematic/dune.webp',
//     'price': 1000.0,
//     'author': 'by frank herbert',
//     'description':
//         'NOW A MAJOR MOTION PICTURE Frank Herberts epic masterpiece--a triumph of the imagination and one of the bestselling science fiction novels of all time. This deluxe hardcover edition of Dune includes: - An iconic new cover- Stained edges and fully illustrated endpapers- A beautifully designed poster on the interior of the jacket- A redesigned world map of Dune- An updated Introduction by Brian Herbert Set on the desert planet Arrakis, Dune is the story of the boy Paul Atreides, heir to a noble family tasked with ruling an inhospitable world where the only thing of value is the spice melange, a drug capable of extending life and enhancing consciousness. Coveted across the known universe, melange is a prize worth killing for... When House Atreides is betrayed, the destruction of Pauls family will set the boy on a journey toward a destiny greater than he could ever have imagined. And as he evolves into the mysterious man known as MuadDib, he will bring to fruition humankinds most ancient and unattainable dream. A stunning blend of adventure and mysticism, environmentalism and politics, Dune won the first Nebula Award, shared the Hugo Award, and formed the basis of what is undoubtedly the grandest epic in science fiction. DUNE is directed by Denis Villeneuve, starring Timothée Chalamet, Zendaya, Jason Momoa, Rebecca Ferguson, Oscar Isaac, Josh Brolin, Stellan Skarsgård, Dave Bautista, Stephen McKinley Henderson, Chang Chen, Charlotte Rampling, and Javier Bardem',
//     'category': 'cinematic', // <-- ADD THIS LINE
//     'createdAt': DateTime.now().toIso8601String(),
//   },
//   {
//     'title': 'Game of Thrones',
//     'image': 'assets/bookImages/got.jpg',
//     'price': 1000.0,
//     'author': 'by George R. R. Martin',
//     'description':
//         'Long ago, in a time forgotten, a preternatural event threw the seasons out of balance. In a land where summers can last decades and winters a lifetime, trouble is brewing. The cold is returning, and in the frozen wastes to the north of Winterfell, sinister forces are massing beyond the kingdoms protective Wall. To the south, the kings powers are failing: his most trusted advisor dead under mysterious circumstances and his enemies emerging from the shadows of the throne. At the center of the conflict lie the Starks of Winterfell, a family as harsh and unyielding as the frozen land they were born to. Now Lord Eddard Stark is reluctantly summoned to serve as the kings new Hand, an appointment that threatens to sunder not only his family but the kingdom itself. Sweeping from a harsh land of cold to a summertime kingdom of epicurean plenty, A Game of Thrones tells a tale of lords and ladies, soldiers and sorcerers, assassins and bastards who come together in a time of grim omens. Here, an enigmatic band of warriors bear swords of no human metal, a tribe of fierce wildings carry men off into madness, a cruel young dragon prince barters ... [more]his sister to win back his throne, a child is lost in the twilight between life and death, and a determined woman undertakes a treacherous journey to protect all she holds dear. Amid plots and counterplots, tragedy and betrayal, victory and terror, allies and enemies, the fate of the Starks hangs perilously in the balance, as each side endeavors to win that deadliest of conflicts: the game of thrones.',
//     'category': 'cinematic', // <-- ADD THIS LINE
//     'createdAt': DateTime.now().toIso8601String(),
//   },
// ];

// final bestSellers = [
//   {
//     'title': 'It End With Us',
//     'image': 'assets/bookImages/newarrival/itendwithus.webp',
//     'price': 200.0,
//     'author': 'by Colleen Hoover',
//     'description':
//         'Instant New York Times Bestseller Combining a captivating romance with a cast of all-too-human characters, Colleen Hoover`s It Ends With Us is an unforgettable tale of love that comes at the ultimate price.Lily hasn`t always had it easy, but that`s never stopped her from working hard for the life she wants. She`s come a long way from the small town in Maine where she grew up—she graduated from college, moved to Boston, and started her own business. So when she feels a spark with a gorgeous neurosurgeon named Ryle Kincaid, everything in Lily`s life suddenly seems almost too good to be true. Ryle is assertive, stubborn, maybe even a little arrogant. He`s also sensitive, brilliant, and has a total soft spot for Lily. And the way he looks in scrubs certainly doesn`t hurt. Lily can`t get him out of her head. But Ryle`s complete aversion to relationships is disturbing. Even as Lily finds herself becoming the exception to his “no dating” rule, she can`t help but wonder what made him that way in the first place. As questions about her new relationship overwhelm her, so do thoughts of Atlas Corrigan—her first love and a link to the past she left behind. He was her kindred spirit, her protector. When Atlas suddenly reappears, everything Lily has built with Ryle is threatened.',
//     'category': 'Best Selling',
//     'createdAt': DateTime.now().toIso8601String(),
//   },
//   {
//     'title': '48 Laws of Power',
//     'image': 'assets/bookImages/bestsellerpage/48lawsofpower.webp',
//     'price': 1598.0,
//     'author': 'by Robert Greene',
//     'description':
//         'Drawn from 3,000 years of the history of power, this is the definitive guide to help readers achieve for themselves what Queen Elizabeth I, Henry Kissinger, Louis XIV and Machiavelli learnt the hard way. Law 1: Never outshine the master Law 2: Never put too much trust in friends; learn how to use enemies Law 3: Conceal your intentions Law 4: Always say less than necessary. The text is bold and elegant, laid out in black and red throughout and replete with fables and unique word sculptures. The 48 laws are illustrated through the tactics, triumphs and failures of great figures from the past who have wielded - or been victimised by - power.',
//     'category': 'Best Selling',
//     'createdAt': DateTime.now().toIso8601String(),
//   },
//   {
//     'title': 'Bhagavad Gita ',
//     'image': 'assets/bookImages/newarrival/bhagavadgita.webp',
//     'price': 200.0,
//     'author': 'by A.C. Bhaktivedanta Swami Prabhupada',
//     'description':
//         'Shrimad Bhagvad Gita was written more than 5000 years ago, and is an integral part of the epic mythology Mahabharata. However, because of its relevance towards leading a holistic life, it has gained prominence over Mahabharata itself. -Unlike spiritual books, which recommend world of renunciation and adoption of life of austerity and penance, Shrimad Bhagavad Gita helps understand how one can enrich his/her life by excelling in the field of his/her aptitude. -It is about a holistic view to life that leads to happiness through practice of sequential and logical methods. Pursuit to Happiness, needs to convert knowledge into intellect -In corporate world, organizations are facing challenges with regard to Ownership, Leadership, Communication, Values, Speed, Integrity, Engagement, Seamlessness, Negotiation, Productivity, Lack of Initiative (inherent fear of things going wrong), Excellence in Execution, Relationship, Gap between Skill and Talent etc -Shrimad Bhagavad Gita has a solution to all the above challenges, provided one engages and works as prescribed. -This book is towards unveiling and understanding the eighteenth chapter of Shrimad Bhagavad Gita. This chapter is a summary of the first seventeen chapters. This not only summarizes but elaborates some points, which are hinted at in earlier chapters. -In today’s life most of us are taking on the battlefield and are in the same state as that of Arjuna. We also need the mentoring of the Lord to remain focussed, and do what is righteous to become more productive personally as well as professionally. -This book will helpdecipher and understand the gist of Shrimad Bhagavad Gita to lead a more holistic life. -Come, ‘Discover the Arjuna in You. Let us patronize our most potent scripture which is our gift to the world',
//     'category': 'Best Selling',
//     'createdAt': DateTime.now().toIso8601String(),
//   },
//   {
//     'title': 'BitterBlue',
//     'image': 'assets/bookImages/newarrival/bitterblue.webp',
//     'price': 200.0,
//     'author': 'by Kristin Cashore',
//     'description':
//         'Eight years after the events of Graceling, Queen Bitterblue is struggling to lead a kingdom still healing from the brutal legacy of her father, King Leck—a madman with the power to control minds. Now eighteen, Bitterblue finds herself surrounded by lies, secrets, and a court that refuses to confront the truth of the past.Determined to understand her kingdom and its people, Bitterblue disguises herself to roam the city streets. What she discovers is a world of hidden rebellion, forgotten history, and dangerous truths that could shake her throne—and her identity.Richly layered with mystery, political intrigue, and emotional depth, Bitterblue is a powerful coming-of-age tale about truth, trauma, and the courage to lead with compassion. A companion to Graceling and Fire, this novel deepens the realm of the Seven Kingdoms in unforgettable ways.',
//     'category': 'Best Selling',
//     'createdAt': DateTime.now().toIso8601String(),
//   },
//   {
//     'title': 'Horrid the Henry',
//     'image': 'assets/bookImages/newarrival/horridthehenry.webp',
//     'price': 200.0,
//     'author': 'by by Francesca Simon',
//     'description':
//         'Early Readers are stepping stones from picture books to reading books. A blue Early Reader is perfect for sharing and reading together. A red Early Reader is the next step on your reading journey.The Queen is coming to visit Horrid Henrys school. The real live Queen! Henry cant believe it. But when Miss Battle-Axe puts him in the back row, Henry is furious. Now how is he meant to find out how many TVs she has? Somehow Henry has to get himself noticed - and show the Queen just how horrid he can be . . .',
//     'category': 'Best Selling',
//     'createdAt': DateTime.now().toIso8601String(),
//   },
//   {
//     'title': 'Murakami',
//     'image': 'assets/bookImages/newarrival/murakami.webp',
//     'price': 200.0,
//     'author': 'by Haruki Murakami',
//     'description':
//         'With Kafka on the Shore, Haruki Murakami gives us a novel every bit as ambitious and expansive as The Wind-Up Bird Chronicle, which has been acclaimed both here and around the world for its uncommon ambition and achievement, and whose still-growing popularity suggests that it will be read and admired for decades to come. This magnificent new novel has a similarly extraordinary scope and the same capacity to amaze, entertain, and bewitch the reader. A tour de force of metaphysical reality, it is powered by two remarkable characters: a teenage boy, Kafka Tamura, who runs away from home either to escape a gruesome oedipal prophecy or to search for his long-missing mother and sister; and an aging simpleton called Nakata, who never recovered from a wartime affliction and now is drawn toward Kafka for reasons that, like the most basic activities of daily life, he cannot fathom. Their odyssey, as mysterious to them as it is to us, is enriched throughout by vivid accomplices and mesmerizing events. Cats and people carry on conversations, a ghostlike pimp employs a Hegel-quoting prostitute, a forest harbors soldiers apparently unaged since World War II, and rainstorms of fish (and worse) fall from the sky. There is a brutal murder, with the identity of both victim and perpetrator a riddle-yet this, along with everything else, is eventually answered, just as the entwined destinies of Kafka and Nakata are gradually revealed, with one escaping his fate entirely and the other given a fresh start on his own. Extravagant in its accomplishment, Kafka on the Shore displays one of the worlds truly great storytellers at the height of his powers.',
//     'category': 'Best Selling',
//     'createdAt': DateTime.now().toIso8601String(),
//   },
//   {
//     'title': 'Usle Diye Ko Umer',
//     'image': 'assets/bookImages/newarrival/uslediyekoumer.webp',
//     'price': 200.0,
//     'author': 'by by Buddhisagar',
//     'description':
//         'आफूसित गाँसिएका स्मृतिलाई शब्दमा उतार्ने बुद्धिसागरको शैली मनमोहक छ । पुस्तक उसले दिएको उमेरमा पनि बुद्धिसागरका स्मृति पढ्दा पाठक आफ्ना पूर्वस्मृतिसम्म पुग्नेछन्– जहाँ उनीहरू नपुगेको धेरै समय भइसकेको हुन सक्छ ।एउटा मानिस यत्तिकै उमेरका खुट्किला उक्लिँदैन । उसले अनेक तीतामीठा घटनाका जङ्घार तर्नुपर्ने हुन्छ । यस पुस्तकमा पनि त्यस्तै जङ्घार छन्, जो सबै मानिससित गाँसिन्छन् । लेखकले लेखेकै छन् कतै- साइकिल सिक्दा गोडामा लागेका खत अझै छन् । सोच्छु– हरेक सिकाइका खत कहीँकतै रहिरहन्छन् । कुनै देखिन्छन्, कुनै देखिँदैनन् ।यी स्मृति मात्र होइनन्, लेखकले सुनाउन चाहेका खतहरू हुन् ।',
//     'category': 'Best Selling',
//     'createdAt': DateTime.now().toIso8601String(),
//   },

//   {
//     'title': 'Seto Dharti',
//     'image': 'assets/bookImages/newarrival/setodharti.webp',
//     'price': 200.0,
//     'author': 'by Amar Neupane',
//     'description':
//         'आफ्नो पहिलो आख्यान पानीको घामका लागि पद्मश्री सम्मान प्राप्त गरेका अमर न्यौपानेको दोस्रो उपन्यास सेतो धरती एक बालविधवाको दर्दनाक कथा हो । यसमा मुख्य पात्र ‘तारा` ले अठहत्तर वर्षको उमेरमा जन्मदेखिको आफ्नो विडम्बनापूर्ण कथा भनेकी छन् । नेपालमा ठूलो भुइँचालो आएको वर्ष ‘नब्बे साल` बाट आरम्भ भएको उपन्यास भुइँचालोभै सुरू भएर भुइँचालोभै अन्त्य हुन्छ । सामाजिक संस्कारका कारण जीवनभर अभिशप्त भएर नियतिको सजायँ भोगेकी ‘तारा` का जीवनका विडम्बनाहरुसँग अन्य पात्रहरुको पनि विडम्बनापूर्ण कथा जोडिएर आउँछ । आञ्चलिकतासँगै सुन्दर भाषामा लेखिएको सेतो धरती २०६८ को मदन पुरस्कार प्राप्त कृति हो ।',
//     'category': 'Best Selling',
//     'createdAt': DateTime.now().toIso8601String(),
//   },

//   {
//     'title': 'Woman Code',
//     'image': 'assets/bookImages/newarrival/womancode.webp',
//     'price': 200.0,
//     'author': 'by Alisa Vitti',
//     'description':
//         'Alisa Vitti found herself suffering through the symptoms of polycystic ovarian syndrome (PCOS), and was able to heal herself through food and lifestyle changes. Relieved and reborn, she made it her mission to empower other women to be able to do the same. As she says, Hormones affect everything. Have you ever struggled with acne, oily hair, dandruff, dry skin, cramps, headaches, irritability, exhaustion, constipation, irregular cycles, heavy bleeding, clotting, shedding hair, weight gain, anxiety, insomnia, infertility, lowered sex drive, or bizarre food cravings and felt like your body was just irrational?With this breadth of symptoms, improving hormonal health is a goal for women at every stage of their lives Alisa Vitti says that medication and anti-depressants arent the only solutions. The thousands of women she has treated in her Manhattan clinic know the power of her process that focuses on uncovering your unique biological make up. Groundbreaking and informative, WomanCode educates women about hormone health in a way thats relevant and easy to understand. Bestselling author and womens health expert Christiane Northrup, who has called WomanCode the Our Bodies, Ourselves of this generation, provides an insightful foreword.',
//     'category': 'Best Selling',
//     'createdAt': DateTime.now().toIso8601String(),
//   },
//   {
//     'title': 'Better Than Movies',
//     'image': 'assets/bookImages/newarrival/betterthanmovies.webp',
//     'price': 200.0,
//     'author': 'by Lynn Painter',
//     'description':
//         'A USA TODAY and New York Times bestseller Perfect for fans of Kasie West and Jenn Bennett, this “sweet and funny” (Kerry Winfrey, author of Waiting for Tom Hanks) teen rom-com follows a hopelessly romantic teen girl and her cute yet obnoxious neighbor as they scheme to get her noticed by her untouchable crush. Perpetual daydreamer Liz Buxbaum gave her heart to Michael a long time ago. But her cool, aloof forever crush never really saw her before he moved away. Now that he’s back in town, Liz will do whatever it takes to get on his radar—and maybe snag him as a prom date—even befriend Wes Bennet. The annoyingly attractive next-door neighbor might seem like a prime candidate for romantic comedy fantasies, but Wes has only been a pain in Liz’s butt since they were kids. Pranks involving frogs and decapitated lawn gnomes do not a potential boyfriend make. Yet, somehow, Wes and Michael are hitting it off, which means Wes is Liz’s in. But as Liz and Wes scheme to get Liz noticed by Michael so she can have her magical prom moment, she’s shocked to discover that she likes being around Wes. And as they continue to grow closer, she must reexamine everything she thought she knew about love—and rethink her own ideas of what Happily Ever After should look like.',
//     'category': 'Best Selling',
//     'createdAt': DateTime.now().toIso8601String(),
//   },

//   {
//     'title': 'Savage Lover',
//     'image': 'assets/bookImages/newarrival/savagelover.webp',
//     'price': 200.0,
//     'author': 'by Sophie Lark',
//     'description':
//         'Two people convinced theyre unworthy of love...until they meet each other. Camille Rivera is drowning. Her fathers sick, her brothers in deep with a dirty cop, and her mechanic shop is failing. Shes growing desperate, trying to keep her world afloat in whatever way she can. Nero Gallo is the neighborhood hazard. A mess-maker. A walking disaster. Camille has watched him burn through every girl in a ten-mile radius, as vicious as he is gorgeous, breaking hearts and never, ever getting attached. Which is why she cant believe it when Nero unexpectedly saves her from a risky situation. Theyve lived next to each other their whole lives, yet shes only ever known him as sin made flesh. Is it possible she didnt really know him at all? They arent friends. They arent allies. But Nero is the only chance Camille has, and shell have to trust theres more to him beneath the savage surface. Except trust is a dangerous thing to give. And Camille is about to learn the only thing more dangerous than trusting Nero is falling for him.',
//     'category': 'Best Selling',
//     'createdAt': DateTime.now().toIso8601String(),
//   },
//   {
//     'title': 'The Love Hyptothesis',
//     'image': 'assets/bookImages/bestsellerpage/thelovehypothesis.webp',
//     'price': 900.0,
//     'author': 'by Ali Hazelwood',
//     'description':
//         'As a third-year Ph.D. candidate, Olive Smith doesnt believe in lasting romantic relationships but her best friend does, and thats what got her into this situation. C onvincing Anh that Olive on her way to a happily ever after was always going to be tough, scientists require proof. So, like any self-respecting woman, Olive panics and kisses the first man she sees. That man is none other than Adam C arlsen, a young hotshot professor and well-known ass. Which is why Olive is positively floored when he agrees to keep her charade a secret and be her fake boyfriend. But when a big science conference goes haywire, their little experiment feels dangerously close to combustion. Olive discovers that the only thing more complicated than a hypothesis on love is putting her own heart under the microscope.',
//   },

//   {
//     'title': 'The Hidden Hindu',
//     'image': 'assets/bookImages/bestsellerpage/thehiddenhindu.webp',
//     'price': 950.0,
//     'author': 'by Akshat Gupta',
//     'description':
//         'Prithvi, a twenty-one-year-old, is searching for a mysterious middle-aged aghori (Shiva devotee), Om Shastri, who was traced more than 200 years ago before he was captured and transported to a high-tech facility on an isolated Indian island. When the aghori was drugged and hypnotized for interrogation by a team of specialists, he claimed to have witnessed all four yugas (the epochs in Hinduism) and even participated in both Ramayana and Mahabharata. Oms revelations of his incredible past that defied the nature of mortality left everyone baffled. The team also discovers that Om had been in search of the other immortals from every yuga. These bizarre secrets could shake up the ancient beliefs of the present and alter the course of the future. So who is Om Shastri? Why was he captured? Board the boat of Om Shastris secrets, Prithvis pursuit and adventures of other enigmatic immortals of Hindu mythology in this exciting and revealing journey.',
//   },
//   {
//     'title': 'How To Talk To Anyone',
//     'image': 'assets/bookImages/bestsellerpage/howtotalktoanyone.webp',
//     'price': 500.0,
//     'author': 'by Leil Lowndes',
//     'description':
//         'A fun, witty and informative guide containing 92 little tricks for big success in personal relationships and business. There are two kinds of people in life. Those who walk into a room and say: Well, here I am!. And those who walk in and say: Ahhh, there you are. In this book, Leil Lowndes writes with wit, irreverence about relationships, body language and how we relate to each other. It contains extremely usable and intelligent strategies for love and business which include: Charming body language and gestures - the exclusive smile, eyes glued to the other person, come hither hands with palms open etc. How to work the party - including making an entrance, be the chooser not the choosee, and mingling not munching (for all those who head straight for the food table!).',
//   },
//   {
//     'title': 'It Starts With Us',
//     'image': 'assets/bookImages/bestsellerpage/itstartswithus.webp',
//     'price': 600.0,
//     'author': 'by Colleen Hoover',
//     'description':
//         'Before It Ends with Us, it started with Atlas. Multi-million copy bestselling author Colleen Hoover tells fan favourite Atlass side of the story and shares what comes next in this long-anticipated sequel to the #1 Sunday Times bestseller It Ends with Us Lily and her ex-husband, Ryle, have just settled into a civil co-parenting rhythm when she suddenly bumps into her first love, Atlas, again. After nearly two years separated, she is elated that for once, time is on their side, and she immediately says yes when Atlas asks her on a date. But her excitement is quickly hampered by the knowledge that, though they are no longer married, Ryle is still very much a part of her life--and Atlas Corrigan is the one man he will hate being in his ex-wife and daughters life. Switching between the perspectives of Lily and Atlas, It Starts with Us picks up right where the epilogue for the bestselling phenomenon It Ends with Us left off. Experience the romantic and satisfying conclusion to Colleen Hoovers powerful global bestselling novel, It Ends with Us.',
//   },

//   {
//     'title': 'Jujutsu kaisen',
//     'image': 'assets/bookImages/bestsellerpage/jujutsu.jpg',
//     'price': 800.0,
//     'author': 'by Gege Akutami',
//     'description':
//         'Yuji Itadori is resolved to save the world from cursed spirits, but he soon learns that the best way to do it is to slowly lose his humanity and become one himself! In a world where cursed spirits feed on unsuspecting humans, fragments of the legendary and feared demon Ryomen Sukuna were lost and scattered about. Should any demon consume Sukunas body parts, the power they gain could destroy the world as we know it. Fortunately, there exists a mysterious school of Jujutsu Sorcerers who exist to protect the precarious existence of the living from the supernatural! Yuta Okkotsu is a nervous high school student who is suffering from a serious problem...his childhood friend Rika has turned into a curse and wont leave him alone. Since Rika is no ordinary curse, his plight gets noticed by Satoru Gojo, a teacher at Jujutsu High, a school where exorcists are taught to combat curses. Gojo convinces him to enroll, but can Yuta learn enough in time to confront the curse that haunts him?',
//   },
//   {
//     'title': 'Lord Of The Rings',
//     'image': 'assets/bookImages/bestsellerpage/lotr.jpg',
//     'price': 700.0,
//     'author': 'by J. R. R. Tolkien',
//     'description':
//         'Continuing the story begun in The Hobbit, all three parts of the epic masterpiece, The Lord of the Rings, in one paperback. Features the definitive edition of the text, fold-out flaps with the original two-colour maps, and a revised and expanded index.Sauron, the Dark Lord, has gathered to him all the Rings of Power – the means by which he intends to rule Middle-earth. All he lacks in his plans for dominion is the One Ring – the ring that rules them all – which has fallen into the hands of the hobbit, Bilbo Baggins.In a sleepy village in the Shire, young Frodo Baggins finds himself faced with an immense task, as the Ring is entrusted to his care. He must leave his home and make a perilous journey across the realms of Middle-earth to the Crack of Doom, deep inside the territories of the Dark Lord. There he must destroy the Ring forever and foil the Dark Lord in his evil purpose.Since it was first published in 1954, The Lord of the Rings has been a book people have treasured. Steeped in unrivalled magic and otherworldliness, its sweeping fantasy has touched the hearts of young and old alike.This single-volume paperback edition is the definitive text, fully restored with almost 400 corrections – with the full co-operation of Christopher Tolkien – and features a striking new cover.',
//   },
// ];

// final newArrivals = [
//   {
//     'title': 'Seto Dharti',
//     'image': 'assets/bookImages/newarrival/setodharti.webp',
//     'price': 200.0,
//     'author': 'by Amar Neupane',
//     'description':
//         'आफ्नो पहिलो आख्यान पानीको घामका लागि पद्मश्री सम्मान प्राप्त गरेका अमर न्यौपानेको दोस्रो उपन्यास सेतो धरती एक बालविधवाको दर्दनाक कथा हो । यसमा मुख्य पात्र ‘तारा` ले अठहत्तर वर्षको उमेरमा जन्मदेखिको आफ्नो विडम्बनापूर्ण कथा भनेकी छन् । नेपालमा ठूलो भुइँचालो आएको वर्ष ‘नब्बे साल` बाट आरम्भ भएको उपन्यास भुइँचालोभै सुरू भएर भुइँचालोभै अन्त्य हुन्छ । सामाजिक संस्कारका कारण जीवनभर अभिशप्त भएर नियतिको सजायँ भोगेकी ‘तारा` का जीवनका विडम्बनाहरुसँग अन्य पात्रहरुको पनि विडम्बनापूर्ण कथा जोडिएर आउँछ । आञ्चलिकतासँगै सुन्दर भाषामा लेखिएको सेतो धरती २०६८ को मदन पुरस्कार प्राप्त कृति हो ।',
//     'category': 'New Arrivals',
//     'createdAt': DateTime.now().toIso8601String(),
//   },

//   {
//     'title': 'Woman Code',
//     'image': 'assets/bookImages/newarrival/womancode.webp',
//     'price': 200.0,
//     'author': 'by Alisa Vitti',
//     'description':
//         'Alisa Vitti found herself suffering through the symptoms of polycystic ovarian syndrome (PCOS), and was able to heal herself through food and lifestyle changes. Relieved and reborn, she made it her mission to empower other women to be able to do the same. As she says, Hormones affect everything. Have you ever struggled with acne, oily hair, dandruff, dry skin, cramps, headaches, irritability, exhaustion, constipation, irregular cycles, heavy bleeding, clotting, shedding hair, weight gain, anxiety, insomnia, infertility, lowered sex drive, or bizarre food cravings and felt like your body was just irrational? With this breadth of symptoms, improving hormonal health is a goal for women at every stage of their lives Alisa Vitti says that medication and anti-depressants arent the only solutions. The thousands of women she has treated in her Manhattan clinic know the power of her process that focuses on uncovering your unique biological make up. Groundbreaking and informative, WomanCode educates women about hormone health in a way thats relevant and easy to understand. Bestselling author and womens health expert Christiane Northrup, who has called WomanCode the Our Bodies, Ourselves of this generation, provides an insightful foreword.',
//     'category': 'New Arrivals',
//     'createdAt': DateTime.now().toIso8601String(),
//   },
//   {
//     'title': 'Better Than Movies',
//     'image': 'assets/bookImages/newarrival/betterthanmovies.webp',
//     'price': 200.0,
//     'author': 'by Lynn Painter',
//     'description':
//         'A USA TODAY and New York Times bestseller Perfect for fans of Kasie West and Jenn Bennett, this “sweet and funny” (Kerry Winfrey, author of Waiting for Tom Hanks) teen rom-com follows a hopelessly romantic teen girl and her cute yet obnoxious neighbor as they scheme to get her noticed by her untouchable crush. Perpetual daydreamer Liz Buxbaum gave her heart to Michael a long time ago. But her cool, aloof forever crush never really saw her before he moved away. Now that he’s back in town, Liz will do whatever it takes to get on his radar—and maybe snag him as a prom date—even befriend Wes Bennet. The annoyingly attractive next-door neighbor might seem like a prime candidate for romantic comedy fantasies, but Wes has only been a pain in Liz’s butt since they were kids. Pranks involving frogs and decapitated lawn gnomes do not a potential boyfriend make. Yet, somehow, Wes and Michael are hitting it off, which means Wes is Liz’s in. But as Liz and Wes scheme to get Liz noticed by Michael so she can have her magical prom moment, she’s shocked to discover that she likes being around Wes. And as they continue to grow closer, she must reexamine everything she thought she knew about love—and rethink her own ideas of what Happily Ever After should look like.',
//     'category': 'New Arrivals',
//     'createdAt': DateTime.now().toIso8601String(),
//   },
//   {
//     'title': 'It End With Us',
//     'image': 'assets/bookImages/newarrival/itendwithus.webp',
//     'price': 200.0,
//     'author': 'by Colleen Hoover',
//     'description':
//         'Instant New York Times Bestseller Combining a captivating romance with a cast of all-too-human characters, Colleen Hoover`s It Ends With Us is an unforgettable tale of love that comes at the ultimate price.Lily hasn`t always had it easy, but that`s never stopped her from working hard for the life she wants. She`s come a long way from the small town in Maine where she grew up—she graduated from college, moved to Boston, and started her own business. So when she feels a spark with a gorgeous neurosurgeon named Ryle Kincaid, everything in Lily`s life suddenly seems almost too good to be true. Ryle is assertive, stubborn, maybe even a little arrogant. He`s also sensitive, brilliant, and has a total soft spot for Lily. And the way he looks in scrubs certainly doesn`t hurt. Lily can`t get him out of her head. But Ryle`s complete aversion to relationships is disturbing. Even as Lily finds herself becoming the exception to his “no dating” rule, she can`t help but wonder what made him that way in the first place. As questions about her new relationship overwhelm her, so do thoughts of Atlas Corrigan—her first love and a link to the past she left behind. He was her kindred spirit, her protector. When Atlas suddenly reappears, everything Lily has built with Ryle is threatened.',
//     'category': 'New Arrivals',
//     'createdAt': DateTime.now().toIso8601String(),
//   },
//   {
//     'title': 'Savage Lover',
//     'image': 'assets/bookImages/newarrival/savagelover.webp',
//     'price': 200.0,
//     'author': 'by Sophie Lark',
//     'description':
//         'Two people convinced theyre unworthy of love...until they meet each other. Camille Rivera is drowning. Her fathers sick, her brothers in deep with a dirty cop, and her mechanic shop is failing. Shes growing desperate, trying to keep her world afloat in whatever way she can. Nero Gallo is the neighborhood hazard. A mess-maker. A walking disaster. Camille has watched him burn through every girl in a ten-mile radius, as vicious as he is gorgeous, breaking hearts and never, ever getting attached. Which is why she cant believe it when Nero unexpectedly saves her from a risky situation. Theyve lived next to each other their whole lives, yet shes only ever known him as sin made flesh. Is it possible she didnt really know him at all? They arent friends. They arent allies. But Nero is the only chance Camille has, and shell have to trust theres more to him beneath the savage surface. Except trust is a dangerous thing to give. And Camille is about to learn the only thing more dangerous than trusting Nero is falling for him.',
//     'category': 'New Arrivals',
//     'createdAt': DateTime.now().toIso8601String(),
//   },
//   {
//     'title': 'The Love Hyptothesis',
//     'image': 'assets/bookImages/bestsellerpage/thelovehypothesis.webp',
//     'price': 900.0,
//     'author': 'by Ali Hazelwood',
//     'description':
//         'As a third-year Ph.D. candidate, Olive Smith doesnt believe in lasting romantic relationships but her best friend does, and thats what got her into this situation. C onvincing Anh that Olive on her way to a happily ever after was always going to be tough, scientists require proof. So, like any self-respecting woman, Olive panics and kisses the first man she sees. That man is none other than Adam C arlsen, a young hotshot professor and well-known ass. Which is why Olive is positively floored when he agrees to keep her charade a secret and be her fake boyfriend. But when a big science conference goes haywire, their little experiment feels dangerously close to combustion. Olive discovers that the only thing more complicated than a hypothesis on love is putting her own heart under the microscope.',
//     'category': 'New Arrivals',
//     'createdAt': DateTime.now().toIso8601String(),
//   },

//   {
//     'title': 'The Hidden Hindu',
//     'image': 'assets/bookImages/bestsellerpage/thehiddenhindu.webp',
//     'price': 950.0,
//     'author': 'by Akshat Gupta',
//     'description':
//         'Prithvi, a twenty-one-year-old, is searching for a mysterious middle-aged aghori (Shiva devotee), Om Shastri, who was traced more than 200 years ago before he was captured and transported to a high-tech facility on an isolated Indian island. When the aghori was drugged and hypnotized for interrogation by a team of specialists, he claimed to have witnessed all four yugas (the epochs in Hinduism) and even participated in both Ramayana and Mahabharata. Oms revelations of his incredible past that defied the nature of mortality left everyone baffled. The team also discovers that Om had been in search of the other immortals from every yuga. These bizarre secrets could shake up the ancient beliefs of the present and alter the course of the future. So who is Om Shastri? Why was he captured? Board the boat of Om Shastris secrets, Prithvis pursuit and adventures of other enigmatic immortals of Hindu mythology in this exciting and revealing journey.',
//     'category': 'New Arrivals',
//     'createdAt': DateTime.now().toIso8601String(),
//   },
//   {
//     'title': 'How To Talk To Anyone',
//     'image': 'assets/bookImages/bestsellerpage/howtotalktoanyone.webp',
//     'price': 500.0,
//     'author': 'by Leil Lowndes',
//     'description':
//         'A fun, witty and informative guide containing 92 little tricks for big success in personal relationships and business. There are two kinds of people in life. Those who walk into a room and say: Well, here I am!. And those who walk in and say: Ahhh, there you are. In this book, Leil Lowndes writes with wit, irreverence about relationships, body language and how we relate to each other. It contains extremely usable and intelligent strategies for love and business which include: Charming body language and gestures - the exclusive smile, eyes glued to the other person, come hither hands with palms open etc. How to work the party - including making an entrance, be the chooser not the choosee, and mingling not munching (for all those who head straight for the food table!).',
//     'category': 'New Arrivals',
//     'createdAt': DateTime.now().toIso8601String(),
//   },
//   {
//     'title': 'It Starts With Us',
//     'image': 'assets/bookImages/bestsellerpage/itstartswithus.webp',
//     'price': 600.0,
//     'author': 'by Colleen Hoover',
//     'description':
//         'Before It Ends with Us, it started with Atlas. Multi-million copy bestselling author Colleen Hoover tells fan favourite Atlass side of the story and shares what comes next in this long-anticipated sequel to the #1 Sunday Times bestseller It Ends with Us Lily and her ex-husband, Ryle, have just settled into a civil co-parenting rhythm when she suddenly bumps into her first love, Atlas, again. After nearly two years separated, she is elated that for once, time is on their side, and she immediately says yes when Atlas asks her on a date. But her excitement is quickly hampered by the knowledge that, though they are no longer married, Ryle is still very much a part of her life--and Atlas Corrigan is the one man he will hate being in his ex-wife and daughters life. Switching between the perspectives of Lily and Atlas, It Starts with Us picks up right where the epilogue for the bestselling phenomenon It Ends with Us left off. Experience the romantic and satisfying conclusion to Colleen Hoovers powerful global bestselling novel, It Ends with Us.',
//     'category': 'New Arrivals',
//     'createdAt': DateTime.now().toIso8601String(),
//   },

//   {
//     'title': 'Jujutsu kaisen',
//     'image': 'assets/bookImages/bestsellerpage/jujutsu.jpg',
//     'price': 800.0,
//     'author': 'by Gege Akutami',
//     'description':
//         'Yuji Itadori is resolved to save the world from cursed spirits, but he soon learns that the best way to do it is to slowly lose his humanity and become one himself! In a world where cursed spirits feed on unsuspecting humans, fragments of the legendary and feared demon Ryomen Sukuna were lost and scattered about. Should any demon consume Sukunas body parts, the power they gain could destroy the world as we know it. Fortunately, there exists a mysterious school of Jujutsu Sorcerers who exist to protect the precarious existence of the living from the supernatural! Yuta Okkotsu is a nervous high school student who is suffering from a serious problem...his childhood friend Rika has turned into a curse and wont leave him alone. Since Rika is no ordinary curse, his plight gets noticed by Satoru Gojo, a teacher at Jujutsu High, a school where exorcists are taught to combat curses. Gojo convinces him to enroll, but can Yuta learn enough in time to confront the curse that haunts him?',
//     'category': 'New Arrivals',
//     'createdAt': DateTime.now().toIso8601String(),
//   },
//   {
//     'title': 'Lord Of The Rings',
//     'image': 'assets/bookImages/bestsellerpage/lotr.jpg',
//     'price': 700.0,
//     'author': 'by J. R. R. Tolkien',
//     'description':
//         'Continuing the story begun in The Hobbit, all three parts of the epic masterpiece, The Lord of the Rings, in one paperback. Features the definitive edition of the text, fold-out flaps with the original two-colour maps, and a revised and expanded index.Sauron, the Dark Lord, has gathered to him all the Rings of Power – the means by which he intends to rule Middle-earth. All he lacks in his plans for dominion is the One Ring – the ring that rules them all – which has fallen into the hands of the hobbit, Bilbo Baggins.In a sleepy village in the Shire, young Frodo Baggins finds himself faced with an immense task, as the Ring is entrusted to his care. He must leave his home and make a perilous journey across the realms of Middle-earth to the Crack of Doom, deep inside the territories of the Dark Lord. There he must destroy the Ring forever and foil the Dark Lord in his evil purpose.Since it was first published in 1954, The Lord of the Rings has been a book people have treasured. Steeped in unrivalled magic and otherworldliness, its sweeping fantasy has touched the hearts of young and old alike.This single-volume paperback edition is the definitive text, fully restored with almost 400 corrections – with the full co-operation of Christopher Tolkien – and features a striking new cover.',
//     'category': 'New Arrivals',
//     'createdAt': DateTime.now().toIso8601String(),
//   },
// ];

// final allBooks = [...cinematic, ...bestSellers, ...newArrivals];
//regular

final List<Map<String, dynamic>> cinematic = [
  {
    'title': 'Lord Of The Rings',
    'image': 'assets/bookImages/bestsellerpage/lotr.jpg',
    'price': 100.0,
    'author': 'by J. R. R. Tolkien',
    'description':
        'Continuing the story begun in The Hobbit, all three parts of the epic masterpiece, The Lord of the Rings, in one paperback. Features the definitive edition of the text, fold-out flaps with the original two-colour maps, and a revised and expanded index.Sauron, the Dark Lord, has gathered to him all the Rings of Power – the means by which he intends to rule Middle-earth. All he lacks in his plans for dominion is the One Ring – the ring that rules them all – which has fallen into the hands of the hobbit, Bilbo Baggins.In a sleepy village in the Shire, young Frodo Baggins finds himself faced with an immense task, as the Ring is entrusted to his care. He must leave his home and make a perilous journey across the realms of Middle-earth to the Crack of Doom, deep inside the territories of the Dark Lord. There he must destroy the Ring forever and foil the Dark Lord in his evil purpose.Since it was first published in 1954, The Lord of the Rings has been a book people have treasured. Steeped in unrivalled magic and otherworldliness, its sweeping fantasy has touched the hearts of young and old alike.This single-volume paperback edition is the definitive text, fully restored with almost 400 corrections – with the full co-operation of Christopher Tolkien – and features a striking new cover.',
    'category': 'cinematic', // <-- ADD THIS LINE
    'createdAt': DateTime.now().toIso8601String(),
  },
  {
    'title': 'Horrid the Henry',
    'image': 'assets/bookImages/newarrival/horridthehenry.webp',
    'price': 200.0,
    'author': 'by by Francesca Simon',
    'description':
        'Early Readers are stepping stones from picture books to reading books. A blue Early Reader is perfect for sharing and reading together. A red Early Reader is the next step on your reading journey.The Queen is coming to visit Horrid Henrys school. The real live Queen! Henry cant believe it. But when Miss Battle-Axe puts him in the back row, Henry is furious. Now how is he meant to find out how many TVs she has? Somehow Henry has to get himself noticed - and show the Queen just how horrid he can be . . .',
    'category': 'cinematic', // <-- ADD THIS LINE
    'createdAt': DateTime.now().toIso8601String(),
  },
  {
    'title': 'Harry Potter',
    'image': 'assets/bookImages/harrypotter.jpg',
    'price': 200.0,
    'author': 'by Andrzej Sapkowski',
    'description':
        ';Meet Geralt of Rivia - the Witcher - who holds the line against the monsters plaguing humanity in the bestselling series that inspired the Witcher video games and a major Netflix show.The Witchers magic powers and lifelong training have made him a brilliant fighter and a merciless assassin.Yet he is no ordinary killer: he hunts the vile fiends that ravage the land and attack the innocent.But not everything monstrous-looking is evil; not everything fair is good . . . and in every fairy tale there is a grain of truth.Translated by Danusia Stok and David French.Andrzej Sapkowski, winner of the World Fantasy Lifetime Achievement award, started an international phenomenon with his Witcher series. This boxed set contains all eight books: THE LAST WISH, SWORD OF DESTINY, BLOOD OF ELVES, TIME OF CONTEMPT, BAPTISM OF FIRE, THE TOWER OF THE SWALLOW, THE LADY OF THE LAKE, SEASON OF STORMS.',
    'category': 'cinematic', // <-- ADD THIS LINE
    'createdAt': DateTime.now().toIso8601String(),
  },
  {
    'title': 'The Witcher',
    'image': 'assets/bookImages/the_witcher.jpg',
    'price': 200.0,
    'author': 'by by J. K. Rowling',
    'description':
        'Harry Potter has never even heard of Hogwarts when the letters start dropping on the doormat at number four, Privet Drive. Addressed in green ink on yellowish parchment with a purple seal, they are swiftly confiscated by his grisly aunt and uncle. Then, on Harrys eleventh birthday, a great beetle-eyed giant of a man called Rubeus Hagrid bursts in with some astonishing news: Harry Potter is a wizard, and he has a place at Hogwarts School of Witchcraft and Wizardry. An incredible adventure is about to begin!These new editions of the classic and internationally bestselling, multi-award-winning series feature instantly pick-up-able new jackets by Jonny Duddle, with huge child appeal, to bring Harry Potter to the next generation of readers. Its time to PASS THE MAGIC ON',
    'category': 'cinematic', // <-- ADD THIS LINE
    'createdAt': DateTime.now().toIso8601String(),
  },
  {
    'title': 'Demon Slayer',
    'image': 'assets/bookImages/Demon_Slayer.jpg',
    'price': 500.0,
    'author': 'by Koyoharu Gotouge',
    'description':
        'Tanjiro sets out on the path of the Demon Slayer to save his sister and avenge his family! In Taisho-era Japan, Tanjiro Kamado is a kindhearted boy who makes a living selling charcoal. But his peaceful life is shattered when a demon slaughters his entire family. His little sister Nezuko is the only survivor, but she has been transformed into a demon herself! Tanjiro sets out on a dangerous journey to find a way to return his sister to normal and destroy the demon who ruined his life. Learning to destroy demons won’t be easy, and Tanjiro barely knows where to start. The surprise appearance of another boy named Giyu, who seems to know what’s going on, might provide some answers—but only if Tanjiro can stop Giyu from killing his sister first!',
    'category': 'cinematic', // <-- ADD THIS LINE
    'createdAt': DateTime.now().toIso8601String(),
  },
  {
    'title': 'Dune',
    'image': 'assets/bookImages/cinematic/dune.webp',
    'price': 1000.0,
    'author': 'by frank herbert',
    'description':
        'NOW A MAJOR MOTION PICTURE Frank Herberts epic masterpiece--a triumph of the imagination and one of the bestselling science fiction novels of all time. This deluxe hardcover edition of Dune includes: - An iconic new cover- Stained edges and fully illustrated endpapers- A beautifully designed poster on the interior of the jacket- A redesigned world map of Dune- An updated Introduction by Brian Herbert Set on the desert planet Arrakis, Dune is the story of the boy Paul Atreides, heir to a noble family tasked with ruling an inhospitable world where the only thing of value is the spice melange, a drug capable of extending life and enhancing consciousness. Coveted across the known universe, melange is a prize worth killing for... When House Atreides is betrayed, the destruction of Pauls family will set the boy on a journey toward a destiny greater than he could ever have imagined. And as he evolves into the mysterious man known as MuadDib, he will bring to fruition humankinds most ancient and unattainable dream. A stunning blend of adventure and mysticism, environmentalism and politics, Dune won the first Nebula Award, shared the Hugo Award, and formed the basis of what is undoubtedly the grandest epic in science fiction. DUNE is directed by Denis Villeneuve, starring Timothée Chalamet, Zendaya, Jason Momoa, Rebecca Ferguson, Oscar Isaac, Josh Brolin, Stellan Skarsgård, Dave Bautista, Stephen McKinley Henderson, Chang Chen, Charlotte Rampling, and Javier Bardem',
    'category': 'cinematic', // <-- ADD THIS LINE
    'createdAt': DateTime.now().toIso8601String(),
  },
  {
    'title': 'Game of Thrones',
    'image': 'assets/bookImages/got.jpg',
    'price': 1000.0,
    'author': 'by George R. R. Martin',
    'description':
        'Long ago, in a time forgotten, a preternatural event threw the seasons out of balance. In a land where summers can last decades and winters a lifetime, trouble is brewing. The cold is returning, and in the frozen wastes to the north of Winterfell, sinister forces are massing beyond the kingdoms protective Wall. To the south, the kings powers are failing: his most trusted advisor dead under mysterious circumstances and his enemies emerging from the shadows of the throne. At the center of the conflict lie the Starks of Winterfell, a family as harsh and unyielding as the frozen land they were born to. Now Lord Eddard Stark is reluctantly summoned to serve as the kings new Hand, an appointment that threatens to sunder not only his family but the kingdom itself. Sweeping from a harsh land of cold to a summertime kingdom of epicurean plenty, A Game of Thrones tells a tale of lords and ladies, soldiers and sorcerers, assassins and bastards who come together in a time of grim omens. Here, an enigmatic band of warriors bear swords of no human metal, a tribe of fierce wildings carry men off into madness, a cruel young dragon prince barters ... [more]his sister to win back his throne, a child is lost in the twilight between life and death, and a determined woman undertakes a treacherous journey to protect all she holds dear. Amid plots and counterplots, tragedy and betrayal, victory and terror, allies and enemies, the fate of the Starks hangs perilously in the balance, as each side endeavors to win that deadliest of conflicts: the game of thrones.',
    'category': 'cinematic', // <-- ADD THIS LINE
    'createdAt': DateTime.now().toIso8601String(),
  },
];

final List<Map<String, dynamic>> bestSelling = [
  {
    'title': 'It End With Us',
    'image': 'assets/bookImages/newarrival/itendwithus.webp',
    'price': 200.0,
    'author': 'by Colleen Hoover',
    'description': 'sdvgsd',
    'category': 'Best Selling',
    'createdAt': DateTime.now().toIso8601String(),
  },
  {
    'title': '48 Laws of Power',
    'image': 'assets/bookImages/bestsellerpage/48lawsofpower.webp',
    'price': 1598.0,
    'author': 'by Robert Greene',
    'description':
        'Drawn from 3,000 years of the history of power, this is the definitive guide to help readers achieve for themselves what Queen Elizabeth I, Henry Kissinger, Louis XIV and Machiavelli learnt the hard way. Law 1: Never outshine the master Law 2: Never put too much trust in friends; learn how to use enemies Law 3: Conceal your intentions Law 4: Always say less than necessary. The text is bold and elegant, laid out in black and red throughout and replete with fables and unique word sculptures. The 48 laws are illustrated through the tactics, triumphs and failures of great figures from the past who have wielded - or been victimised by - power.',
    'category': 'Best Selling',
    'createdAt': DateTime.now().toIso8601String(),
  },
  {
    'title': 'Bhagavad Gita ',
    'image': 'assets/bookImages/newarrival/bhagavadgita.webp',
    'price': 200.0,
    'author': 'by A.C. Bhaktivedanta Swami Prabhupada',
    'description':
        'Shrimad Bhagvad Gita was written more than 5000 years ago, and is an integral part of the epic mythology Mahabharata. However, because of its relevance towards leading a holistic life, it has gained prominence over Mahabharata itself. -Unlike spiritual books, which recommend world of renunciation and adoption of life of austerity and penance, Shrimad Bhagavad Gita helps understand how one can enrich his/her life by excelling in the field of his/her aptitude. -It is about a holistic view to life that leads to happiness through practice of sequential and logical methods. Pursuit to Happiness, needs to convert knowledge into intellect -In corporate world, organizations are facing challenges with regard to Ownership, Leadership, Communication, Values, Speed, Integrity, Engagement, Seamlessness, Negotiation, Productivity, Lack of Initiative (inherent fear of things going wrong), Excellence in Execution, Relationship, Gap between Skill and Talent etc -Shrimad Bhagavad Gita has a solution to all the above challenges, provided one engages and works as prescribed. -This book is towards unveiling and understanding the eighteenth chapter of Shrimad Bhagavad Gita. This chapter is a summary of the first seventeen chapters. This not only summarizes but elaborates some points, which are hinted at in earlier chapters. -In today’s life most of us are taking on the battlefield and are in the same state as that of Arjuna. We also need the mentoring of the Lord to remain focussed, and do what is righteous to become more productive personally as well as professionally. -This book will helpdecipher and understand the gist of Shrimad Bhagavad Gita to lead a more holistic life. -Come, ‘Discover the Arjuna in You. Let us patronize our most potent scripture which is our gift to the world',
    'category': 'Best Selling',
    'createdAt': DateTime.now().toIso8601String(),
  },
  {
    'title': 'BitterBlue',
    'image': 'assets/bookImages/newarrival/bitterblue.webp',
    'price': 200.0,
    'author': 'by Kristin Cashore',
    'description':
        'Eight years after the events of Graceling, Queen Bitterblue is struggling to lead a kingdom still healing from the brutal legacy of her father, King Leck—a madman with the power to control minds. Now eighteen, Bitterblue finds herself surrounded by lies, secrets, and a court that refuses to confront the truth of the past.Determined to understand her kingdom and its people, Bitterblue disguises herself to roam the city streets. What she discovers is a world of hidden rebellion, forgotten history, and dangerous truths that could shake her throne—and her identity.Richly layered with mystery, political intrigue, and emotional depth, Bitterblue is a powerful coming-of-age tale about truth, trauma, and the courage to lead with compassion. A companion to Graceling and Fire, this novel deepens the realm of the Seven Kingdoms in unforgettable ways.',
    'category': 'Best Selling',
    'createdAt': DateTime.now().toIso8601String(),
  },
  {
    'title': 'Horrid the Henry',
    'image': 'assets/bookImages/newarrival/horridthehenry.webp',
    'price': 200.0,
    'author': 'by by Francesca Simon',
    'description':
        'Early Readers are stepping stones from picture books to reading books. A blue Early Reader is perfect for sharing and reading together. A red Early Reader is the next step on your reading journey.The Queen is coming to visit Horrid Henrys school. The real live Queen! Henry cant believe it. But when Miss Battle-Axe puts him in the back row, Henry is furious. Now how is he meant to find out how many TVs she has? Somehow Henry has to get himself noticed - and show the Queen just how horrid he can be . . .',
    'category': 'Best Selling',
    'createdAt': DateTime.now().toIso8601String(),
  },
  {
    'title': 'Murakami',
    'image': 'assets/bookImages/newarrival/murakami.webp',
    'price': 200.0,
    'author': 'by Haruki Murakami',
    'description':
        'With Kafka on the Shore, Haruki Murakami gives us a novel every bit as ambitious and expansive as The Wind-Up Bird Chronicle, which has been acclaimed both here and around the world for its uncommon ambition and achievement, and whose still-growing popularity suggests that it will be read and admired for decades to come. This magnificent new novel has a similarly extraordinary scope and the same capacity to amaze, entertain, and bewitch the reader. A tour de force of metaphysical reality, it is powered by two remarkable characters: a teenage boy, Kafka Tamura, who runs away from home either to escape a gruesome oedipal prophecy or to search for his long-missing mother and sister; and an aging simpleton called Nakata, who never recovered from a wartime affliction and now is drawn toward Kafka for reasons that, like the most basic activities of daily life, he cannot fathom. Their odyssey, as mysterious to them as it is to us, is enriched throughout by vivid accomplices and mesmerizing events. Cats and people carry on conversations, a ghostlike pimp employs a Hegel-quoting prostitute, a forest harbors soldiers apparently unaged since World War II, and rainstorms of fish (and worse) fall from the sky. There is a brutal murder, with the identity of both victim and perpetrator a riddle-yet this, along with everything else, is eventually answered, just as the entwined destinies of Kafka and Nakata are gradually revealed, with one escaping his fate entirely and the other given a fresh start on his own. Extravagant in its accomplishment, Kafka on the Shore displays one of the worlds truly great storytellers at the height of his powers.',
    'category': 'Best Selling',
    'createdAt': DateTime.now().toIso8601String(),
  },
  {
    'title': 'Usle Diye Ko Umer',
    'image': 'assets/bookImages/newarrival/uslediyekoumer.webp',
    'price': 200.0,
    'author': 'by by Buddhisagar',
    'description':
        'आफूसित गाँसिएका स्मृतिलाई शब्दमा उतार्ने बुद्धिसागरको शैली मनमोहक छ । पुस्तक उसले दिएको उमेरमा पनि बुद्धिसागरका स्मृति पढ्दा पाठक आफ्ना पूर्वस्मृतिसम्म पुग्नेछन्– जहाँ उनीहरू नपुगेको धेरै समय भइसकेको हुन सक्छ ।एउटा मानिस यत्तिकै उमेरका खुट्किला उक्लिँदैन । उसले अनेक तीतामीठा घटनाका जङ्घार तर्नुपर्ने हुन्छ । यस पुस्तकमा पनि त्यस्तै जङ्घार छन्, जो सबै मानिससित गाँसिन्छन् । लेखकले लेखेकै छन् कतै- साइकिल सिक्दा गोडामा लागेका खत अझै छन् । सोच्छु– हरेक सिकाइका खत कहीँकतै रहिरहन्छन् । कुनै देखिन्छन्, कुनै देखिँदैनन् ।यी स्मृति मात्र होइनन्, लेखकले सुनाउन चाहेका खतहरू हुन् ।',
    'category': 'Best Selling',
    'createdAt': DateTime.now().toIso8601String(),
  },

  {
    'title': 'Seto Dharti',
    'image': 'assets/bookImages/newarrival/setodharti.webp',
    'price': 200.0,
    'author': 'by Amar Neupane',
    'description':
        'आफ्नो पहिलो आख्यान पानीको घामका लागि पद्मश्री सम्मान प्राप्त गरेका अमर न्यौपानेको दोस्रो उपन्यास सेतो धरती एक बालविधवाको दर्दनाक कथा हो । यसमा मुख्य पात्र ‘तारा` ले अठहत्तर वर्षको उमेरमा जन्मदेखिको आफ्नो विडम्बनापूर्ण कथा भनेकी छन् । नेपालमा ठूलो भुइँचालो आएको वर्ष ‘नब्बे साल` बाट आरम्भ भएको उपन्यास भुइँचालोभै सुरू भएर भुइँचालोभै अन्त्य हुन्छ । सामाजिक संस्कारका कारण जीवनभर अभिशप्त भएर नियतिको सजायँ भोगेकी ‘तारा` का जीवनका विडम्बनाहरुसँग अन्य पात्रहरुको पनि विडम्बनापूर्ण कथा जोडिएर आउँछ । आञ्चलिकतासँगै सुन्दर भाषामा लेखिएको सेतो धरती २०६८ को मदन पुरस्कार प्राप्त कृति हो ।',
    'category': 'Best Selling',
    'createdAt': DateTime.now().toIso8601String(),
  },

  {
    'title': 'Woman Code',
    'image': 'assets/bookImages/newarrival/womancode.webp',
    'price': 200.0,
    'author': 'by Alisa Vitti',
    'description':
        'Alisa Vitti found herself suffering through the symptoms of polycystic ovarian syndrome (PCOS), and was able to heal herself through food and lifestyle changes. Relieved and reborn, she made it her mission to empower other women to be able to do the same. As she says, Hormones affect everything. Have you ever struggled with acne, oily hair, dandruff, dry skin, cramps, headaches, irritability, exhaustion, constipation, irregular cycles, heavy bleeding, clotting, shedding hair, weight gain, anxiety, insomnia, infertility, lowered sex drive, or bizarre food cravings and felt like your body was just irrational?With this breadth of symptoms, improving hormonal health is a goal for women at every stage of their lives Alisa Vitti says that medication and anti-depressants arent the only solutions. The thousands of women she has treated in her Manhattan clinic know the power of her process that focuses on uncovering your unique biological make up. Groundbreaking and informative, WomanCode educates women about hormone health in a way thats relevant and easy to understand. Bestselling author and womens health expert Christiane Northrup, who has called WomanCode the Our Bodies, Ourselves of this generation, provides an insightful foreword.',
    'category': 'Best Selling',
    'createdAt': DateTime.now().toIso8601String(),
  },
  {
    'title': 'Better Than Movies',
    'image': 'assets/bookImages/newarrival/betterthanmovies.webp',
    'price': 200.0,
    'author': 'by Lynn Painter',
    'description':
        'A USA TODAY and New York Times bestseller Perfect for fans of Kasie West and Jenn Bennett, this “sweet and funny” (Kerry Winfrey, author of Waiting for Tom Hanks) teen rom-com follows a hopelessly romantic teen girl and her cute yet obnoxious neighbor as they scheme to get her noticed by her untouchable crush. Perpetual daydreamer Liz Buxbaum gave her heart to Michael a long time ago. But her cool, aloof forever crush never really saw her before he moved away. Now that he’s back in town, Liz will do whatever it takes to get on his radar—and maybe snag him as a prom date—even befriend Wes Bennet. The annoyingly attractive next-door neighbor might seem like a prime candidate for romantic comedy fantasies, but Wes has only been a pain in Liz’s butt since they were kids. Pranks involving frogs and decapitated lawn gnomes do not a potential boyfriend make. Yet, somehow, Wes and Michael are hitting it off, which means Wes is Liz’s in. But as Liz and Wes scheme to get Liz noticed by Michael so she can have her magical prom moment, she’s shocked to discover that she likes being around Wes. And as they continue to grow closer, she must reexamine everything she thought she knew about love—and rethink her own ideas of what Happily Ever After should look like.',
    'category': 'Best Selling',
    'createdAt': DateTime.now().toIso8601String(),
  },

  {
    'title': 'Savage Lover',
    'image': 'assets/bookImages/newarrival/savagelover.webp',
    'price': 200.0,
    'author': 'by Sophie Lark',
    'description':
        'Two people convinced theyre unworthy of love...until they meet each other. Camille Rivera is drowning. Her fathers sick, her brothers in deep with a dirty cop, and her mechanic shop is failing. Shes growing desperate, trying to keep her world afloat in whatever way she can. Nero Gallo is the neighborhood hazard. A mess-maker. A walking disaster. Camille has watched him burn through every girl in a ten-mile radius, as vicious as he is gorgeous, breaking hearts and never, ever getting attached. Which is why she cant believe it when Nero unexpectedly saves her from a risky situation. Theyve lived next to each other their whole lives, yet shes only ever known him as sin made flesh. Is it possible she didnt really know him at all? They arent friends. They arent allies. But Nero is the only chance Camille has, and shell have to trust theres more to him beneath the savage surface. Except trust is a dangerous thing to give. And Camille is about to learn the only thing more dangerous than trusting Nero is falling for him.',
    'category': 'Best Selling',
    'createdAt': DateTime.now().toIso8601String(),
  },
  {
    'title': 'The Love Hyptothesis',
    'image': 'assets/bookImages/bestsellerpage/thelovehypothesis.webp',
    'price': 900.0,
    'author': 'by Ali Hazelwood',
    'description':
        'As a third-year Ph.D. candidate, Olive Smith doesnt believe in lasting romantic relationships but her best friend does, and thats what got her into this situation. C onvincing Anh that Olive on her way to a happily ever after was always going to be tough, scientists require proof. So, like any self-respecting woman, Olive panics and kisses the first man she sees. That man is none other than Adam C arlsen, a young hotshot professor and well-known ass. Which is why Olive is positively floored when he agrees to keep her charade a secret and be her fake boyfriend. But when a big science conference goes haywire, their little experiment feels dangerously close to combustion. Olive discovers that the only thing more complicated than a hypothesis on love is putting her own heart under the microscope.',
  },

  {
    'title': 'The Hidden Hindu',
    'image': 'assets/bookImages/bestsellerpage/thehiddenhindu.webp',
    'price': 950.0,
    'author': 'by Akshat Gupta',
    'description':
        'Prithvi, a twenty-one-year-old, is searching for a mysterious middle-aged aghori (Shiva devotee), Om Shastri, who was traced more than 200 years ago before he was captured and transported to a high-tech facility on an isolated Indian island. When the aghori was drugged and hypnotized for interrogation by a team of specialists, he claimed to have witnessed all four yugas (the epochs in Hinduism) and even participated in both Ramayana and Mahabharata. Oms revelations of his incredible past that defied the nature of mortality left everyone baffled. The team also discovers that Om had been in search of the other immortals from every yuga. These bizarre secrets could shake up the ancient beliefs of the present and alter the course of the future. So who is Om Shastri? Why was he captured? Board the boat of Om Shastris secrets, Prithvis pursuit and adventures of other enigmatic immortals of Hindu mythology in this exciting and revealing journey.',
  },
  {
    'title': 'How To Talk To Anyone',
    'image': 'assets/bookImages/bestsellerpage/howtotalktoanyone.webp',
    'price': 500.0,
    'author': 'by Leil Lowndes',
    'description':
        'A fun, witty and informative guide containing 92 little tricks for big success in personal relationships and business. There are two kinds of people in life. Those who walk into a room and say: Well, here I am!. And those who walk in and say: Ahhh, there you are. In this book, Leil Lowndes writes with wit, irreverence about relationships, body language and how we relate to each other. It contains extremely usable and intelligent strategies for love and business which include: Charming body language and gestures - the exclusive smile, eyes glued to the other person, come hither hands with palms open etc. How to work the party - including making an entrance, be the chooser not the choosee, and mingling not munching (for all those who head straight for the food table!).',
  },
  {
    'title': 'It Starts With Us',
    'image': 'assets/bookImages/bestsellerpage/itstartswithus.webp',
    'price': 600.0,
    'author': 'by Colleen Hoover',
    'description':
        'Before It Ends with Us, it started with Atlas. Multi-million copy bestselling author Colleen Hoover tells fan favourite Atlass side of the story and shares what comes next in this long-anticipated sequel to the #1 Sunday Times bestseller It Ends with Us Lily and her ex-husband, Ryle, have just settled into a civil co-parenting rhythm when she suddenly bumps into her first love, Atlas, again. After nearly two years separated, she is elated that for once, time is on their side, and she immediately says yes when Atlas asks her on a date. But her excitement is quickly hampered by the knowledge that, though they are no longer married, Ryle is still very much a part of her life--and Atlas Corrigan is the one man he will hate being in his ex-wife and daughters life. Switching between the perspectives of Lily and Atlas, It Starts with Us picks up right where the epilogue for the bestselling phenomenon It Ends with Us left off. Experience the romantic and satisfying conclusion to Colleen Hoovers powerful global bestselling novel, It Ends with Us.',
  },

  {
    'title': 'Jujutsu kaisen',
    'image': 'assets/bookImages/bestsellerpage/jujutsu.jpg',
    'price': 800.0,
    'author': 'by Gege Akutami',
    'description':
        'Yuji Itadori is resolved to save the world from cursed spirits, but he soon learns that the best way to do it is to slowly lose his humanity and become one himself! In a world where cursed spirits feed on unsuspecting humans, fragments of the legendary and feared demon Ryomen Sukuna were lost and scattered about. Should any demon consume Sukunas body parts, the power they gain could destroy the world as we know it. Fortunately, there exists a mysterious school of Jujutsu Sorcerers who exist to protect the precarious existence of the living from the supernatural! Yuta Okkotsu is a nervous high school student who is suffering from a serious problem...his childhood friend Rika has turned into a curse and wont leave him alone. Since Rika is no ordinary curse, his plight gets noticed by Satoru Gojo, a teacher at Jujutsu High, a school where exorcists are taught to combat curses. Gojo convinces him to enroll, but can Yuta learn enough in time to confront the curse that haunts him?',
  },
  {
    'title': 'Lord Of The Rings',
    'image': 'assets/bookImages/bestsellerpage/lotr.jpg',
    'price': 700.0,
    'author': 'by J. R. R. Tolkien',
    'description':
        'Continuing the story begun in The Hobbit, all three parts of the epic masterpiece, The Lord of the Rings, in one paperback. Features the definitive edition of the text, fold-out flaps with the original two-colour maps, and a revised and expanded index.Sauron, the Dark Lord, has gathered to him all the Rings of Power – the means by which he intends to rule Middle-earth. All he lacks in his plans for dominion is the One Ring – the ring that rules them all – which has fallen into the hands of the hobbit, Bilbo Baggins.In a sleepy village in the Shire, young Frodo Baggins finds himself faced with an immense task, as the Ring is entrusted to his care. He must leave his home and make a perilous journey across the realms of Middle-earth to the Crack of Doom, deep inside the territories of the Dark Lord. There he must destroy the Ring forever and foil the Dark Lord in his evil purpose.Since it was first published in 1954, The Lord of the Rings has been a book people have treasured. Steeped in unrivalled magic and otherworldliness, its sweeping fantasy has touched the hearts of young and old alike.This single-volume paperback edition is the definitive text, fully restored with almost 400 corrections – with the full co-operation of Christopher Tolkien – and features a striking new cover.',
  },
];

final List<Map<String, dynamic>> newArrivals = [
  {
    'title': 'Seto Dharti',
    'image': 'assets/bookImages/newarrival/setodharti.webp',
    'price': 200.0,
    'author': 'by Amar Neupane',
    'description':
        'आफ्नो पहिलो आख्यान पानीको घामका लागि पद्मश्री सम्मान प्राप्त गरेका अमर न्यौपानेको दोस्रो उपन्यास सेतो धरती एक बालविधवाको दर्दनाक कथा हो । यसमा मुख्य पात्र ‘तारा` ले अठहत्तर वर्षको उमेरमा जन्मदेखिको आफ्नो विडम्बनापूर्ण कथा भनेकी छन् । नेपालमा ठूलो भुइँचालो आएको वर्ष ‘नब्बे साल` बाट आरम्भ भएको उपन्यास भुइँचालोभै सुरू भएर भुइँचालोभै अन्त्य हुन्छ । सामाजिक संस्कारका कारण जीवनभर अभिशप्त भएर नियतिको सजायँ भोगेकी ‘तारा` का जीवनका विडम्बनाहरुसँग अन्य पात्रहरुको पनि विडम्बनापूर्ण कथा जोडिएर आउँछ । आञ्चलिकतासँगै सुन्दर भाषामा लेखिएको सेतो धरती २०६८ को मदन पुरस्कार प्राप्त कृति हो ।',
    'category': 'New Arrivals',
    'createdAt': DateTime.now().toIso8601String(),
  },

  {
    'title': 'Woman Code',
    'image': 'assets/bookImages/newarrival/womancode.webp',
    'price': 200.0,
    'author': 'by Alisa Vitti',
    'description':
        'Alisa Vitti found herself suffering through the symptoms of polycystic ovarian syndrome (PCOS), and was able to heal herself through food and lifestyle changes. Relieved and reborn, she made it her mission to empower other women to be able to do the same. As she says, Hormones affect everything. Have you ever struggled with acne, oily hair, dandruff, dry skin, cramps, headaches, irritability, exhaustion, constipation, irregular cycles, heavy bleeding, clotting, shedding hair, weight gain, anxiety, insomnia, infertility, lowered sex drive, or bizarre food cravings and felt like your body was just irrational? With this breadth of symptoms, improving hormonal health is a goal for women at every stage of their lives Alisa Vitti says that medication and anti-depressants arent the only solutions. The thousands of women she has treated in her Manhattan clinic know the power of her process that focuses on uncovering your unique biological make up. Groundbreaking and informative, WomanCode educates women about hormone health in a way thats relevant and easy to understand. Bestselling author and womens health expert Christiane Northrup, who has called WomanCode the Our Bodies, Ourselves of this generation, provides an insightful foreword.',
    'category': 'New Arrivals',
    'createdAt': DateTime.now().toIso8601String(),
  },
  {
    'title': 'Better Than Movies',
    'image': 'assets/bookImages/newarrival/betterthanmovies.webp',
    'price': 200.0,
    'author': 'by Lynn Painter',
    'description':
        'A USA TODAY and New York Times bestseller Perfect for fans of Kasie West and Jenn Bennett, this “sweet and funny” (Kerry Winfrey, author of Waiting for Tom Hanks) teen rom-com follows a hopelessly romantic teen girl and her cute yet obnoxious neighbor as they scheme to get her noticed by her untouchable crush. Perpetual daydreamer Liz Buxbaum gave her heart to Michael a long time ago. But her cool, aloof forever crush never really saw her before he moved away. Now that he’s back in town, Liz will do whatever it takes to get on his radar—and maybe snag him as a prom date—even befriend Wes Bennet. The annoyingly attractive next-door neighbor might seem like a prime candidate for romantic comedy fantasies, but Wes has only been a pain in Liz’s butt since they were kids. Pranks involving frogs and decapitated lawn gnomes do not a potential boyfriend make. Yet, somehow, Wes and Michael are hitting it off, which means Wes is Liz’s in. But as Liz and Wes scheme to get Liz noticed by Michael so she can have her magical prom moment, she’s shocked to discover that she likes being around Wes. And as they continue to grow closer, she must reexamine everything she thought she knew about love—and rethink her own ideas of what Happily Ever After should look like.',
    'category': 'New Arrivals',
    'createdAt': DateTime.now().toIso8601String(),
  },
  {
    'title': 'It End With Us',
    'image': 'assets/bookImages/newarrival/itendwithus.webp',
    'price': 200.0,
    'author': 'by Colleen Hoover',
    'description':
        'Instant New York Times Bestseller Combining a captivating romance with a cast of all-too-human characters, Colleen Hoover`s It Ends With Us is an unforgettable tale of love that comes at the ultimate price.Lily hasn`t always had it easy, but that`s never stopped her from working hard for the life she wants. She`s come a long way from the small town in Maine where she grew up—she graduated from college, moved to Boston, and started her own business. So when she feels a spark with a gorgeous neurosurgeon named Ryle Kincaid, everything in Lily`s life suddenly seems almost too good to be true. Ryle is assertive, stubborn, maybe even a little arrogant. He`s also sensitive, brilliant, and has a total soft spot for Lily. And the way he looks in scrubs certainly doesn`t hurt. Lily can`t get him out of her head. But Ryle`s complete aversion to relationships is disturbing. Even as Lily finds herself becoming the exception to his “no dating” rule, she can`t help but wonder what made him that way in the first place. As questions about her new relationship overwhelm her, so do thoughts of Atlas Corrigan—her first love and a link to the past she left behind. He was her kindred spirit, her protector. When Atlas suddenly reappears, everything Lily has built with Ryle is threatened.',
    'category': 'New Arrivals',
    'createdAt': DateTime.now().toIso8601String(),
  },
  {
    'title': 'Savage Lover',
    'image': 'assets/bookImages/newarrival/savagelover.webp',
    'price': 200.0,
    'author': 'by Sophie Lark',
    'description':
        'Two people convinced theyre unworthy of love...until they meet each other. Camille Rivera is drowning. Her fathers sick, her brothers in deep with a dirty cop, and her mechanic shop is failing. Shes growing desperate, trying to keep her world afloat in whatever way she can. Nero Gallo is the neighborhood hazard. A mess-maker. A walking disaster. Camille has watched him burn through every girl in a ten-mile radius, as vicious as he is gorgeous, breaking hearts and never, ever getting attached. Which is why she cant believe it when Nero unexpectedly saves her from a risky situation. Theyve lived next to each other their whole lives, yet shes only ever known him as sin made flesh. Is it possible she didnt really know him at all? They arent friends. They arent allies. But Nero is the only chance Camille has, and shell have to trust theres more to him beneath the savage surface. Except trust is a dangerous thing to give. And Camille is about to learn the only thing more dangerous than trusting Nero is falling for him.',
    'category': 'New Arrivals',
    'createdAt': DateTime.now().toIso8601String(),
  },
  {
    'title': 'The Love Hyptothesis',
    'image': 'assets/bookImages/bestsellerpage/thelovehypothesis.webp',
    'price': 900.0,
    'author': 'by Ali Hazelwood',
    'description':
        'As a third-year Ph.D. candidate, Olive Smith doesnt believe in lasting romantic relationships but her best friend does, and thats what got her into this situation. C onvincing Anh that Olive on her way to a happily ever after was always going to be tough, scientists require proof. So, like any self-respecting woman, Olive panics and kisses the first man she sees. That man is none other than Adam C arlsen, a young hotshot professor and well-known ass. Which is why Olive is positively floored when he agrees to keep her charade a secret and be her fake boyfriend. But when a big science conference goes haywire, their little experiment feels dangerously close to combustion. Olive discovers that the only thing more complicated than a hypothesis on love is putting her own heart under the microscope.',
    'category': 'New Arrivals',
    'createdAt': DateTime.now().toIso8601String(),
  },

  {
    'title': 'The Hidden Hindu',
    'image': 'assets/bookImages/bestsellerpage/thehiddenhindu.webp',
    'price': 950.0,
    'author': 'by Akshat Gupta',
    'description':
        'Prithvi, a twenty-one-year-old, is searching for a mysterious middle-aged aghori (Shiva devotee), Om Shastri, who was traced more than 200 years ago before he was captured and transported to a high-tech facility on an isolated Indian island. When the aghori was drugged and hypnotized for interrogation by a team of specialists, he claimed to have witnessed all four yugas (the epochs in Hinduism) and even participated in both Ramayana and Mahabharata. Oms revelations of his incredible past that defied the nature of mortality left everyone baffled. The team also discovers that Om had been in search of the other immortals from every yuga. These bizarre secrets could shake up the ancient beliefs of the present and alter the course of the future. So who is Om Shastri? Why was he captured? Board the boat of Om Shastris secrets, Prithvis pursuit and adventures of other enigmatic immortals of Hindu mythology in this exciting and revealing journey.',
    'category': 'New Arrivals',
    'createdAt': DateTime.now().toIso8601String(),
  },
  {
    'title': 'How To Talk To Anyone',
    'image': 'assets/bookImages/bestsellerpage/howtotalktoanyone.webp',
    'price': 500.0,
    'author': 'by Leil Lowndes',
    'description':
        'A fun, witty and informative guide containing 92 little tricks for big success in personal relationships and business. There are two kinds of people in life. Those who walk into a room and say: Well, here I am!. And those who walk in and say: Ahhh, there you are. In this book, Leil Lowndes writes with wit, irreverence about relationships, body language and how we relate to each other. It contains extremely usable and intelligent strategies for love and business which include: Charming body language and gestures - the exclusive smile, eyes glued to the other person, come hither hands with palms open etc. How to work the party - including making an entrance, be the chooser not the choosee, and mingling not munching (for all those who head straight for the food table!).',
    'category': 'New Arrivals',
    'createdAt': DateTime.now().toIso8601String(),
  },
  {
    'title': 'It Starts With Us',
    'image': 'assets/bookImages/bestsellerpage/itstartswithus.webp',
    'price': 600.0,
    'author': 'by Colleen Hoover',
    'description':
        'Before It Ends with Us, it started with Atlas. Multi-million copy bestselling author Colleen Hoover tells fan favourite Atlass side of the story and shares what comes next in this long-anticipated sequel to the #1 Sunday Times bestseller It Ends with Us Lily and her ex-husband, Ryle, have just settled into a civil co-parenting rhythm when she suddenly bumps into her first love, Atlas, again. After nearly two years separated, she is elated that for once, time is on their side, and she immediately says yes when Atlas asks her on a date. But her excitement is quickly hampered by the knowledge that, though they are no longer married, Ryle is still very much a part of her life--and Atlas Corrigan is the one man he will hate being in his ex-wife and daughters life. Switching between the perspectives of Lily and Atlas, It Starts with Us picks up right where the epilogue for the bestselling phenomenon It Ends with Us left off. Experience the romantic and satisfying conclusion to Colleen Hoovers powerful global bestselling novel, It Ends with Us.',
    'category': 'New Arrivals',
    'createdAt': DateTime.now().toIso8601String(),
  },

  {
    'title': 'Jujutsu kaisen',
    'image': 'assets/bookImages/bestsellerpage/jujutsu.jpg',
    'price': 800.0,
    'author': 'by Gege Akutami',
    'description':
        'Yuji Itadori is resolved to save the world from cursed spirits, but he soon learns that the best way to do it is to slowly lose his humanity and become one himself! In a world where cursed spirits feed on unsuspecting humans, fragments of the legendary and feared demon Ryomen Sukuna were lost and scattered about. Should any demon consume Sukunas body parts, the power they gain could destroy the world as we know it. Fortunately, there exists a mysterious school of Jujutsu Sorcerers who exist to protect the precarious existence of the living from the supernatural! Yuta Okkotsu is a nervous high school student who is suffering from a serious problem...his childhood friend Rika has turned into a curse and wont leave him alone. Since Rika is no ordinary curse, his plight gets noticed by Satoru Gojo, a teacher at Jujutsu High, a school where exorcists are taught to combat curses. Gojo convinces him to enroll, but can Yuta learn enough in time to confront the curse that haunts him?',
    'category': 'New Arrivals',
    'createdAt': DateTime.now().toIso8601String(),
  },
  {
    'title': 'Lord Of The Rings',
    'image': 'assets/bookImages/bestsellerpage/lotr.jpg',
    'price': 700.0,
    'author': 'by J. R. R. Tolkien',
    'description':
        'Continuing the story begun in The Hobbit, all three parts of the epic masterpiece, The Lord of the Rings, in one paperback. Features the definitive edition of the text, fold-out flaps with the original two-colour maps, and a revised and expanded index.Sauron, the Dark Lord, has gathered to him all the Rings of Power – the means by which he intends to rule Middle-earth. All he lacks in his plans for dominion is the One Ring – the ring that rules them all – which has fallen into the hands of the hobbit, Bilbo Baggins.In a sleepy village in the Shire, young Frodo Baggins finds himself faced with an immense task, as the Ring is entrusted to his care. He must leave his home and make a perilous journey across the realms of Middle-earth to the Crack of Doom, deep inside the territories of the Dark Lord. There he must destroy the Ring forever and foil the Dark Lord in his evil purpose.Since it was first published in 1954, The Lord of the Rings has been a book people have treasured. Steeped in unrivalled magic and otherworldliness, its sweeping fantasy has touched the hearts of young and old alike.This single-volume paperback edition is the definitive text, fully restored with almost 400 corrections – with the full co-operation of Christopher Tolkien – and features a striking new cover.',
    'category': 'New Arrivals',
    'createdAt': DateTime.now().toIso8601String(),
  },
];

Future<List<Book>> getInitialBooks() async {
  List<Book> booksToSeed = [];
  final List<Map<String, dynamic>> allStaticBooksData = [
    ...newArrivals,
    ...bestSelling,
    ...cinematic,
  ];

  print('Starting to process initial book data...'); // Debug print

  for (var bookMap in allStaticBooksData) {
    // --- IMPORTANT DEBUGGING LOGS ---
    print('\n--- Processing Book: ${bookMap['title'] ?? 'UNKNOWN TITLE'} ---');
    print('Raw Map: $bookMap');
    print('Category: ${bookMap['category']} (Type: ${bookMap['category']?.runtimeType})');
    print('CreatedAt: ${bookMap['createdAt']} (Type: ${bookMap['createdAt']?.runtimeType})');
    print('Image Path: ${bookMap['image']} (Type: ${bookMap['image']?.runtimeType})');
    print('Author: ${bookMap['author']} (Type: ${bookMap['author']?.runtimeType})');
    print('Description: ${bookMap['description']} (Type: ${bookMap['description']?.runtimeType})');

    Uint8List? imageBytes;
    try {
      // This cast is where the "image path" null error would occur if 'image' key is missing or null
      imageBytes = await _getImageBytesFromAsset(bookMap['image'] as String);
    } catch (e) {
      print('Error loading image for ${bookMap['title'] ?? 'UNKNOWN TITLE'}: $e');
      imageBytes = null;
    }

    // --- Cast and assign values ---
    final String title = bookMap['title'] as String? ?? 'Untitled';
    final String author = bookMap['author'] as String? ?? 'Unknown Author';
    final String description = bookMap['description'] as String? ?? 'No description available.';
    final double price =
        (bookMap['price'] as num?)?.toDouble() ?? 0.0; // Safely convert, default to 0.0
    final String category =
        bookMap['category'] as String ?? 'General'; // This is the MOST LIKELY culprit

    DateTime createdAt;
    try {
      // This cast is where the "createdAt" null error would occur if 'createdAt' key is missing or null
      createdAt = DateTime.parse(bookMap['createdAt'] as String);
    } catch (e) {
      print('WARNING: Could not parse createdAt for "$title". Using current time. Error: $e');
      createdAt = DateTime.now();
    }

    booksToSeed.add(
      Book(
        title: title,
        author: author,
        description: description,
        price: price,
        category: category,
        imageBytes: imageBytes,
        createdAt: createdAt,
      ),
    );
  }
  print(
    'Finished processing initial book data. Total books to seed: ${booksToSeed.length}',
  ); // Debug print

  return booksToSeed;
}
