IntDict counts;
int smallestText;
int largestText;

void setup( ) {
    size(800, 800);
    background(255);
    fill(0);

    // Variables used for mapping the counts of a word to a fontsize
    smallestText = 8;
    largestText = 64;

    // Initialize our dictionary
    counts = new IntDict();
    // Load our textfile line by line into array
    String[] lines = loadStrings("text.txt");
    // Join lines together to single string
    String combinedText = join(lines, "\n");
    // Split the combined text into individual words
    String[] words = splitTokens(combinedText, "\" ()[]{}.,:;!?");
    // Iterate over all the words
    for(String word : words){
        word = word.toLowerCase();
        if(counts.hasKey(word)){
            // Increment our count if the word has been encountered before
            counts.increment(word);
        } else {
            // Add the word with a count of 1 if it is new
            counts.set(word, 1);
        }
    }
    // Sort the dictionary from lowest to highest wordcount
    counts.sortValues();

    // Get an array of the vals and the keys so we can iterate over the keys and values
    // from lowest count value to highest simultaneously
    String[] keys = counts.keyArray();
    int[] vals = counts.valueArray();

    // Get the lowest and highest wordcount to be used later for mapping
    int loCount = vals[0];
    int hiCount = vals[vals.length-1];

    // Iterate over all the keys in our dictionary
    for(int i = 0; i < keys.length; i++){
        // Set the textsize by mapping the words count from the lowest and highest
        // count in the dictionary to the smallestText and largestText variables.
        textSize(map(vals[i], loCount, hiCount, smallestText, largestText));
        // Display the word at a random position inside the window
        text(keys[i], random(width), random(height));
    }

}
