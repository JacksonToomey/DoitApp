//
//  ApiClient.swift
//  DoitApp
//
//  Created by Jackson Toomey on 10/31/18.
//  Copyright © 2018 Jackson Toomey. All rights reserved.
//

import Foundation


class ApiClient {
    static func getChoreDefinitions(_ completion: ([ChoreDefinition]) -> Void) {
        completion([
            ChoreDefinition(
                id: "1",
                name: "Test Chore",
                details: "Test Chore",
                frequencyAmount: 2,
                frequencyType: FrequencyTypes(rawValue: "days")!
            )
        ])
    }
    
    static func getUpcomingChores(_ completion: @escaping (_ upcomingChores: [UpcomingChore]) -> Void) {
        let url = URL(string: "https://api.doit.jtoid.com/api/upcoming")!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            DispatchQueue.main.async {
                completion([
                    UpcomingChore(
                        id: "1",
                        name: "Test Chore",
                        details: """
Leela's gonna kill me. Oh, but you can. But you may have to metaphorically make a deal with the devil. And by "devil", I mean Robot Devil. And by "metaphorically", I mean get your coat. Yes, except the Dave Matthews Band doesn't rock.

Fry, we have a crate to deliver. Good news, everyone! There's a report on TV with some very bad news! Kids have names? Yes, I saw. You were doing well, until everyone died. Good man. Nixon's pro-war and pro-family.

Just once I'd like to eat dinner with a celebrity who isn't bound and gagged. When will that be? How much did you make me? Kids don't turn rotten just from watching TV. Guards! Bring me the forms I need to fill out to have her taken away!

Hey, whatcha watching? Ooh, name it after me! You've killed me! Oh, you've killed me! I don't 'need' to drink. I can quit anytime I want! Michelle, I don't regret this, but I both rue and lament it.

You can see how I lived before I met you. I could if you hadn't turned on the light and shut off my stereo. Yeah. Give a little credit to our public schools. I never loved you. You seem malnourished. Are you suffering from intestinal parasites?

Yes. You gave me a dollar and some candy. That's a popular name today. Little "e", big "B"? Tell her you just want to talk. It has nothing to do with mating. Quite possible. We live long and are celebrated poopers.

Oh no! The professor will hit me! But if Zoidberg 'fixes' it… then perhaps gifts! Morbo can't understand his teleprompter because he forgot how you say that letter that's shaped like a man wearing a hat.
""",
                        dueDate: "2018-11-03T04:00:00+00:00"
                    ),
                    UpcomingChore(
                        id: "2",
                        name: "Test Chore 2",
                        details: """
Bender, this is Fry's decision… and he made it wrong. So it's time for us to interfere in his life. Shut up and get to the point! No, I'm Santa Claus! Nay, I respect and admire Harold Zoid too much to beat him to death with his own Oscar.

Um, is this the boring, peaceful kind of taking to the streets? Hey, whatcha watching? Fry, you can't just sit here in the dark listening to classical music. Hey, you add a one and two zeros to that or we walk!

I decline the title of Iron Cook and accept the lesser title of Zinc Saucier, which I just made up. Uhh… also, comes with double prize money. As an interesting side note, as a head without a body, I envy the dead.

I feel like I was mauled by Jesus. Do a flip! I haven't felt much of anything since my guinea pig died. Come, Comrade Bender! We must take to the streets! In our darkest hour, we can stand erect, with proud upthrust bosoms.
""",
                        dueDate: "2018-11-10T04:00:00+00:00"
                    ),
                ])
            }
        }
        
        task.resume()
    }
}
