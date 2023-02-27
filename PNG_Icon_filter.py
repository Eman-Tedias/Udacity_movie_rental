import pandas as pd
import numpy as np

table = pd.read_csv(r'D:\Estudo\Data_Science\Projetos\Locadora_SQL\CSV_files\Utilizado\Film_info_att.csv')

category_icons = {
    'Horror': 'https://i.ibb.co/YDK7scS/HORROR.png',
 'Documentary': 'https://i.ibb.co/HzC8HhJ/DOCUMENTARY.png',
 'New': 'https://i.ibb.co/y5wGX3M/NEW.png',
 'Classics': 'https://i.ibb.co/tx8qrb5/CLASSICS.png',
 'Games': 'https://i.ibb.co/RhDgkQV/GAMES.png',
 'Sci-Fi': 'https://i.ibb.co/2qNzGp4/SCI-FI.png',
 'Foreign': 'https://i.ibb.co/Ky7c46P/FOREIGN.png',
 'Family': 'https://i.ibb.co/C066RtX/FAMILY.png',
 'Travel': 'https://i.ibb.co/xsF6d99/TRAVEL.png',
 'Music': 'https://i.ibb.co/5FtM6Xg/MUSIC.png',
 'Sports': 'https://i.ibb.co/9YktFXG/SPORTS.png',
 'Comedy': 'https://i.ibb.co/pRcS9qP/COMEDY.png',
 'Drama': 'https://i.ibb.co/DPF6NzY/DRAMA.png',
 'Action': 'https://i.ibb.co/YtpcQ4Q/ACTION.png',
 'Children': 'https://i.ibb.co/nrs56cC/CHILDREN.png',
 'Animation': 'https://i.ibb.co/hFtYt0f/ANIMATION.png'
}

def get_category_icon(row):
    name = row['name']
    return category_icons.get(name, None)

table['category_images'] = table.apply(get_category_icon, axis=1)

table.to_csv(r'D:\Estudo\Data_Science\Projetos\Locadora_SQL\CSV_files\Utilizado\Film_info_att.csv', index=False)