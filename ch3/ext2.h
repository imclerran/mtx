#ifndef EXT2_H
#define EXT2_H

#define u32 unsigned long
#define u16 unsigned short
#define u8 unsigned char

typedef struct ext2_inode {
	u16 i_mode;			/* File mode */
	u16 i_uid;			/* Owner Uid */
	u32 i_size;			/* Size in bytes */
	u32 i_atime;		/* Access time */
	u32 i_ctime;		/* Creation time */
	u32 i_mtime;		/* Modification time */
	u32 i_dtime;		/* Deletion time */
	u16 i_gid;			/* Group Id */
	u16 i_links_count;	/* Links count */
	u32 i_blocks;		/* Blocks count */
	u32 i_flags;		/* File flags */
	u32 dummy;
	u32 i_block[15];	/* Pointers to blocks */
	u32 pad[7];			/* inode size must be 128 bytes */

} INODE;

typedef struct ext2_dir_entry_2 {
	u32 inode;			/* Inode number */
	u16 rec_len;		/* Directory entry length */
	u8 name_len;		/* Name length */
	u8 file_type;
	char name[256];		/* File name */
} DIR;

#endif EXT2_H
