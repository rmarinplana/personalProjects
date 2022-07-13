import random
import pygame

# Initialize pygame
pygame.init()

# Create screen
screen = pygame.display.set_mode((800, 600))

# Set title and icon
pygame.display.set_caption("Space Invaders")
icon = pygame.image.load("games/space_invaders/icon.png")
pygame.display.set_icon(icon)

# Background sound
pygame.mixer.music.load("games/space_invaders/background.wav")
pygame.mixer.music.play(-1)

# Player
player_img = pygame.image.load("games/space_invaders/player.png")
player_x = 370
player_y = 500
player_x_change = 0
player_y_change = 0

# Alien
alien_img = pygame.image.load("games/space_invaders/alien.png")
alien_x = []
alien_y = []
alien_x_change = []
alien_y_change = 30
for i in range(14):
    alien_x.append(i*50)
    alien_y.append(10)
    alien_x_change.append(0.1)
    

# Bullet
bullet_img = pygame.image.load("games/space_invaders/bullet.png")
bullet_x = 370
bullet_y = 500
bullet_y_change = 0.5
bullet_state = "ready"

# Score
score = 0

# Font
font_1 = pygame.font.Font("freesansbold.ttf", 32)
font_2 = pygame.font.Font("freesansbold.ttf", 64)

# Game over
is_game_over = False

def player(player_x, player_y):
    screen.blit(player_img, (player_x, player_y))

def alien(alien_x, alien_y):
        screen.blit(alien_img, (alien_x, alien_y))

def fire_bullet(bullet_x, bullet_y):
    global bullet_state
    bullet_state = "fire"
    screen.blit(bullet_img, (bullet_x, bullet_y))

def is_collision(alien_x, alien_y, bullet_x, bullet_y):
    distance = ((alien_x - bullet_x)**2 + (alien_y - bullet_y)**2)**0.5
    if distance < 16: 
        return True
    else: 
        return False

def show_score(x=10, y=10):
    score_board = font_1.render("Score: "+ str(score), True, (255, 255, 255))
    screen.blit(score_board, (x, y))

def game_over_text():
    game_over_text = font_2.render("GAME OVER", True, (255, 255, 255))
    screen.blit(game_over_text, (200, 250))

# Game loop
running = True
while running:

    # Set screen color - RGB
    screen.fill((0, 0, 0))

    for event in pygame.event.get():
        # Close game tab
        if event.type==pygame.QUIT:
            running=False
            
        # Define key mechanics
        if event.type == pygame.KEYDOWN:
            if event.key==pygame.K_RIGHT:
                player_x_change = 0.3
            if event.key==pygame.K_LEFT:
                player_x_change = -0.3
            if event.key==pygame.K_UP:
                player_y_change = -0.2
            if event.key==pygame.K_DOWN:
                player_y_change = 0.2
            if event.key==pygame.K_SPACE:
                if bullet_state == "ready":
                    bullet_x = player_x + 24
                    bullet_y = player_y
                    fire_bullet(bullet_x, bullet_y)
                    pygame.mixer.Sound("games/space_invaders/laser.wav").play()
        if event.type == pygame.KEYUP:
            if event.key == pygame.K_RIGHT or event.key == pygame.K_LEFT:
                player_x_change = 0
            if event.key == pygame.K_UP or event.key == pygame.K_DOWN:
                player_y_change = 0

    # Player movement
    player_x += player_x_change
    player_y += player_y_change
    # Player boundries
    if player_x < 0: player_x = 0
    elif player_x > 736: player_x = 736
    elif player_y < 0: player_y = 0
    elif player_y > 530: player_y = 530

    player(player_x, player_y)

    # Bullet movement
    if bullet_y < 0:
        bullet_state = "ready"

    if bullet_state == "fire":
        bullet_y -= bullet_y_change
        fire_bullet(bullet_x, bullet_y)
        

    # Alien movement
    for i in range(len(alien_x)):
        # Game over
        alien_player_distance = ((alien_x[i] - player_x)**2 + (alien_y[i] - player_y)**2)**0.5
        if alien_player_distance <= 20 or alien_y[i] > 560:
            is_game_over = True

        if is_game_over == True:
            game_over_text()
            break
    
        if is_game_over == False:
            if alien_x[i] < 0:
                alien_x_change[i] = alien_x_change[i]*-1
                alien_y[i] += alien_y_change
            elif alien_x[i] > 768:
                alien_x_change[i] = alien_x_change[i]*-1
                alien_y[i] += alien_y_change
            alien_x[i] += alien_x_change[i]


        # Collision
        collision = is_collision(alien_x[i], alien_y[i], bullet_x, bullet_y)
        if collision:
            pygame.mixer.Sound("games/space_invaders/explosion.wav").play()
            bullet_state = "ready"
            bullet_x = 1000
            bullet_y = 1000
            score += 1
            alien_x[i] = 10
            alien_y[i] = 10
            alien_x_change[i] = abs(alien_x_change[i])+0.1
        
        alien(alien_x[i], alien_y[i])
    
    show_score()

    pygame.display.update()
        