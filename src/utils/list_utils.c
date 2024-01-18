/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   list_utils.c                                       :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: alde-oli <alde-oli@student.42lausanne.c    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2023/12/13 13:36:15 by dvandenb          #+#    #+#             */
/*   Updated: 2024/01/11 10:20:16 by alde-oli         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "structs.h"
#include "minirt.h"

t_obj	*add_back(t_obj **front, t_obj *obj)
{
	t_obj	*cur;

	if (!*front)
	{
		*front = obj;
		return (obj);
	}
	cur = *front;
	while (cur->next)
		cur = cur->next;
	cur->next = obj;
	return (obj);
}

t_obj	*new_obj(int type, t_scene *s)
{
	t_obj	*temp;
	int		*type_p;

	temp = ft_malloc(sizeof(t_obj), s);
	type_p = malloc(sizeof(int));
	if (!type)
		free(temp);
	ft_error(!type, "Unable to allocate space\n", 0, s);
	*type_p = type;
	*temp = (t_obj){.type = type_p};
	return (temp);
}

t_p	*new_p(float x, float y, float z, t_scene *s)
{
	t_p	*temp;

	temp = ft_malloc(sizeof(t_p), s);
	*temp = (t_p){.x = x, .y = y, .z = z};
	return (temp);
}

int	count_char(char *str, char c)
{
	int	i;

	i = 0;
	while (*str)
		if (*str++ == c)
			i++;
	return (i);
}
