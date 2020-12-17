# Matheus Henrique Schaly
# Simulado 1 - Bucket Sort

_, _ = input().split()
words = input().split()

# Get the size of each word
size_words = []
biggest_1 = 0
for word in words:
    size_words.append((len(word), word))
    if len(word) > biggest_1:
        biggest_1 = len(word)

# Set each word to its bucket using the size
buckets_1 = [[] for _ in range(biggest_1)]
for size_word in size_words:
    buckets_1[size_word[0] - 1].append(size_word)

# Get the position of each letter for each word
word_positions = []
biggest_2 = 0
for word in words:
    for i in range(len(word), 0, -1):
        word_positions.append((i, word[i-1]))
        size = int(ord(word[i-1]))
        if size > biggest_2:
            biggest_2 = size

# Set each letter to its bucket
buckets_2 = [[] for _ in range(biggest_2)]
for word_position in word_positions:
    buckets_2[int(ord(word_position[1])) - 1].append(word_position)

# Order each letter
words_ordered = []
for word_list in buckets_2:
    for word in word_list:
        words_ordered.append(word)

# Separate each letter according to the word length
buckets_3 = [[] for _ in range(biggest_1)]
for i in range(len(words_ordered)):
    word = words_ordered[i]
    index = int(words_ordered[i][0]) - 1
    if not buckets_3[index]:
        buckets_3[index].append(word)
    elif buckets_3[index][-1] != word:
        buckets_3[index].append(word)

[print(x) for x in buckets_3]

# Bucket sort
S = [[] for _ in range(biggest_2)]
size = buckets_1[::-1][0][0][0]
for w in buckets_1[::-1]:
    for s in S:
        if s:
            for s_aux in s:
                w.append(s_aux)
    S = [[] for _ in range(biggest_2)]
    for word in w:
        S[int(ord(word[1][size-1])-1)].append(word)
    size -= 1

# Print the input ordered
print()
for s in S:
    for s_aux in s:
        print(s_aux[1], end=' ')
