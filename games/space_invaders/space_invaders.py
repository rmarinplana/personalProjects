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

# Player
player_img = pygame.image.load("games/space_invaders/player.png")
player_x = 370
player_y = 500
player_x_change = 0

# Alien
alien_img = pygame.image.load("games/space_invaders/alien.png")
alien_x = random.randint(0, 768)
alien_y = 0
alien_x_change = 0.15
alien_y_change = 15

# Bullet
bullet_img = pygame.image.load("games/space_invaders/bullet.png")
bullet_x = 370
bullet_y = 500
bullet_y_change = 0.5
bullet_state = "ready"

def player(player_x, player_y):
    screen.blit(player_img, (player_x, player_y))

def alien(alien_x, alien_y):
    screen.blit(alien_img, (alien_x, alien_y))

def fire_bullet(bullet_x, bullet_y):
    global bullet_state
    bullet_state = "fire"
    screen.blit(bullet_img, (bullet_x, bullet_y))

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
            if event.key==pygame.K_SPACE:
                bullet_x = player_x + 24
                fire_bullet(bullet_x, bullet_y)
        if event.type == pygame.KEYUP:
            if event.key == pygame.K_RIGHT or event.key == pygame.K_LEFT:
                player_x_change = 0

        # Player movement
    player_x += player_x_change
    # Player boundries
    if player_x < 0:
        player_x = 0
    elif player_x > 736:
        player_x = 736

    # Alien movement
    alien_x += alien_x_change
    if alien_x < 0:
        alien_x_change = 0.15
        alien_y += alien_y_change
    elif alien_x > 768:
        alien_x_change = -0.15
        alien_y += alien_y_change

    # Bullet movement
    if bullet_y == 0:
        bullet_state = "ready"
        bullet_y = player_y

    if bullet_state == "fire":
        fire_bullet(bullet_x, bullet_y)
        bullet_y -= bullet_y_change
    
    player(player_x, player_y)
    alien(alien_x, alien_y)

    pygame.display.update()
        